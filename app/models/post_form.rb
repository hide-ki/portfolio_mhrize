class PostForm
  include ActiveModel::Model
  
  attr_accessor :character_gender, :user_id, :image, :image_cache,
                :head_armor_id, :body_armor_id, :arm_armor_id, :waist_armor_id, :foot_armor_id,
                :type, :name
                # :part, :hue, :saturation, :value

  delegate :persisted?, to: :post

  def initialize(attributes = nil, post: Post.new)
    @post = post
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      head_armor = HeadArmor.create(type: type, name: name)
      body_armor = BodyArmor.create(type: type, name: name)
      arm_armor = ArmArmor.create(type: type, name: name)
      waist_armor = WaistArmor.create(type: type, name: name)
      foot_armor = FootArmor.create(type: type, name: name)
      post.update!(character_gender: character_gender, user_id: user_id,
                  image: image, head_armor_id: head_armor.id, body_armor_id: body_armor.id,
                  arm_armor_id: arm_armor.id, waist_armor_id: waist_armor.id, foot_armor_id: foot_armor.id)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def to_model
    post
  end

  private

  attr_reader :post

  def default_attributes
    {
      character_gender: post.character_gender,
      user_id: post.user_id,
      image: post.image
    }
  end
end