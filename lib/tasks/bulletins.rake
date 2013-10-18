namespace :bulletins do
  task :refresh_from_facebook => :environment do
    client = Mogli::Client.new(ENV['FACEBOOK_API_TOKEN'])
    little_hippie_page = Mogli::Page.find(ENV['LITTLE_HIPPIE_FACEBOOK_PAGE_ID'], client)
    posts = little_hippie_page.posts
    posts.each do |post|
      message = post.message
      if message
        b = Bulletin.create :title => 'Facebook Post', :content => post.message, :active => true, :teaser => message[/[^\.\!\?]*[\.\!\?]/], :created_at => post.created_time
        home = ContentPage.find_by_slug 'home'
        BulletinPairing.create :bulletin => b, :content_page => home
      end
    end
  end
end
