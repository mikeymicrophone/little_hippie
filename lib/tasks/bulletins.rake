require 'open-uri'
namespace :bulletins do
  task :refresh_from_facebook => :environment do
    client = Mogli::Client.new(ENV['FACEBOOK_API_TOKEN'])
    little_hippie_page = Mogli::Page.find(ENV['LITTLE_HIPPIE_FACEBOOK_PAGE_ID'], client)
    posts = little_hippie_page.posts
    posts.each do |post|
      message = post.message
      picture = post.picture.andand.gsub('_s.jpg', '_n.jpg')
      if message
        bulletin = Bulletin.create :title => 'Facebook Post', :content => post.message, :active => true, :teaser => message[/[^\.\!\?]*[\.\!\?]/], :facebook_image_url => picture, :facebook_post_id => post.id, :created_at => post.created_time, :og_type => post.type, :og_url => post.link
        if bulletin.valid?
          home = ContentPage.find_by_slug 'home'
          pairing = BulletinPairing.create :bulletin => bulletin, :content_page => home
          pairing.move_to_top
          likes = post.likes["data"]
          likes.each do |like_data|
            l = bulletin.likes.new :facebook_user_id => like_data["id"], :facebook_user_name => like_data["name"]
            if customer = Customer.find_by_facebook_id(like_data["id"])
              l.customer_id = customer.id
            end
            l.save
          end
          if picture
            banner = Banner.new :name => 'Facebook Posted Image'
            banner.remote_image_url = picture
            banner.save
            bulletin.update_attribute :banner_id, banner.id
          end
        end
      end
    end
  end
  
  task :count_shares_of_posts => :environment do
    client = Mogli::Client.new(ENV['FACEBOOK_API_TOKEN'])
    products = Product.where(:preview => true).where.not(:target_post_id => nil)
    products.each do |product|
      id = product.target_post_id
      share_list = open "https://graph.facebook.com/v2.3/#{id}/sharedposts?access_token=#{ENV['FACEBOOK_SHARE_COUNTER_TOKEN']}&limit=50"
      share_data = JSON.parse share_list.read
      if share_data['data'].length >= product.target_share_count
        product.update_attribute :preview, false
      end
    end
  end
end
