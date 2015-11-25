class Movie < ActiveRecord::Base
  has_many :reviews
  mount_uploader :poster_image, PosterImageUploader
  
  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :poster_image_url,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size if reviews.size > 0
  end

  def self.search(search, duration)
      query = "%#{search}%"
      duration = "runtime_in_minutes #{duration}"
      @movies = Movie.where("title like ? or director like ?", query, query).where(duration)
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
  
end
