require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

module AddAttraction
  attr_reader :command_hooks
  attr_reader :attributes
  
  #######################################
  ## Main function for Add Attraction. ##
  ## All other functions are helper.   ##
  def run ###############################
    init_command_hooks()
    parse_attraction(options[:location] + "/#{args[0]}.markdown")
    return unless publish?

    move_image_from(options[:location] + "/#{args[0]}.png")
    attributes[:img_url] = options[:img_url] + "/#{args[0]}.png"

    if publish?
      puts "Publishing"
      unless attraction = Attraction.first(:conditions => {:title => attributes[:title]})
        Attraction.create(attributes)
      else
        attraction.attributes = attributes
        attraction.save
      end
    end
  end
  
  def parse_attraction(file_name)
    @attributes = {}
    file = File.open(file_name,'r')

    while( line = file.readline and not (line =~ /@(\w+)/).nil? )
      attribute = $1
      line.slice!('@'+attribute)
      line.strip!
      
      if command_hooks[attribute].nil?
        attributes[attribute.to_sym] = line
      else
        command_hooks[attribute].call line
      end
    end

    attributes[:body] = file.read
    attributes[:outline] = parse_sections(attributes[:body])
    attributes
  end
  # Moves image to proper location in public folder
  def move_image_from(img_loc)
    root = File.expand_path(File.dirname(__FILE__) + "/../")
    system("mkdir #{root}/public/#{options[:img_url]}") unless File.exist?(root + "/public/images/attractions")
    
    new_img_loc = root + "/public/#{options[:img_url]}"
    system("cp #{img_loc} #{new_img_loc}")
  end
  
  def parse_sections(text)
    body = StringIO.new(text)
    outline = []
    while(not body.eof?)
      line = body.readline
      if( (line =~ /#/) == 0)
        #H1 is the title so so first layer is H2 (which is ## in markdown)
        outline.push( [ line.gsub('#','').strip, line.count('#') - 1 ] )
      end
    end
    outline
  end
  # I know you are not going to like this... but I am going to clean it up!
  def init_command_hooks
    @command_hooks = {}
    @command_hooks['status'] = Proc.new { |line|
      if( (line =~ /:(\w+)/) == 0)
        command = $1
        line.slice!(':'+command); line.gsub!("=>",''); line.strip!
        case command
        when "published":
          @publish = true
          if( (line =~ /(.[0-9])\.(.[0-9])\.(.[0-9])/) == 0 )
            attributes[:when] = Date.new($3.to_i,$1.to_i,$2.to_i) #year month day
          end
        else puts "Undefined option for Publish, #{command}"
        end
      end
    } 
  end
  
  def publish?
    @publish || false
  end
end
