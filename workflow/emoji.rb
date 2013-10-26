class Emoji

  def emojis
    @emojis
  end

  # Emoji constructor
  def initialize(query = '')
    @emojis = load_emojis
    select!(query.split)
  end
  
  # Load Emojis from emoji folder
  def load_emojis
    Dir.glob("./emoji/*.png").map do |path|
      File.basename(path, ".png")
    end.compact.uniq.sort
  end
  
  # Filter with arguments
  def select!(queries, emojis = @emojis)
    queries.each do |q|
      # use reject! for ruby 1.8 compatible
      emojis.reject! do |i|
        i.index(q.downcase) ? false : true
      end
    end
  end
    
  # Return results to Alfred
  def to_alfred(alfred)
    add_items(alfred.feedback).to_alfred
  end

  # Add formatted data from emojis
  def add_items(feedback, emojis = @emojis)
    emojis.each do |emoji|
      feedback.add_item(item_hash(emoji))
    end
    feedback
  end

  # Alfred item format
  def item_hash(emoji)
    {
      :uid      => "",
      :title    => emoji,
      :subtitle => "Copy to clipboard :#{emoji}:",
      :arg      => emoji,
      :icon     => { :type => "default", :name => "./emoji/#{emoji}.png" },
      :valid    => "yes",
    }
  end
end