class Article < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: {minimum: 5}
  validates :text, presence: true
  validates :status, inclusion: {in: ["Public", "Archived"]}

  scope :archived_count, -> {where(status: 'Archived').count}

  before_save :capitalize_sentence, :upcase_first_word, on: [:create, :update]

  def archived?
    status == "Archived"
  end

  protected
    def capitalize_sentence
      self.title = title.titleize
    end

    def upcase_first_word
      str1 = self.text.split(". ")
      str2 = str1.map {|i| i.capitalize}
      self.text = str2.join(". ")
    end
    

    def username(email)
        username = email.split("@")
        username[0]
    end

end