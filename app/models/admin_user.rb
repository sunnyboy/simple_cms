require 'digest/sha1' # integrácia knižnice heslovania SHA1

class AdminUser < ActiveRecord::Base
  # To configure a different table name: set_table_name("table_name")
  
  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, :through => :section_edits
  
  attr_protected :password # virtuálny atribút, ktorý nieje uložný v databáze 
  
  EMAIL_REGEX=/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  # často a globálne používané kňštanty sa môžu definovať v config/initializers/constants.rb
  # ak súbor config/initializers/constants.rb neexistuje, treba ho vytvoriť
  
  validates_presence_of     :first_name
  validates_length_of       :first_name, :within => 2..30
  validates_presence_of     :last_name
  validates_length_of       :last_name, :within => 2..50
  validates_presence_of     :username
  validates_length_of       :username, :within => 8..25
  validates_uniqueness_of   :username
  validates_presence_of     :email
  validates_length_of       :email, :maximum => 100
  validates_format_of       :email, :with => EMAIL_REGEX
  validates_confirmation_of :email  # vytvotí virtuálne pole email_confirmation, ktoré sa testuje len ak je na stránke prítomné
  
  validates_length_of :password, :within => 4..25, :on => :create  #only on create, so that other attributes of this user can be changed
  # vyssie uvedeny test testuje dlzku hesla len ked sa user vytvara. pri dalsich updates moze byt heslo prazdne- co znamena ze ho nemodifikujem

  #callbacks- zastavia vykonávanie kódu v určitom okamžiku a vykonajú definovanú metódu
  # callbacks metódy sa často definujú ako private
  before_save :create_hashed_password
  after_save  :clear_password
  
  scope :named, lambda {|first,last| where(:first_name => first, :last_name=>last)}
  scope :sorted, order("admin_users.last_name ASC, admin_users.first_name ASC")
  
  attr_protected :hashed_password, :salt
  # ochrana atribútov pre "mass asignment"... tieto atribúty sa nedáju modifikovať cez params
  # opačna možnosť je attr_accessible
  # modifikácia priamim priradením je vždy možná
  
  def name
    "#{first_name} #{last_name}"
    # metoda ktroa jednoducho vrati meno a priezvisko
  end
  def password_match? (password="")
    hashed_password == AdminUser.hash_with_salt(password, salt)
    # The same password string with the same hash method and salt
    # should always generate the same hashed_password.
  end
  def self.authenticate(username="", password="")
    #  uvedene metody maju pred nazvom self preto aby sa dali volat aj bez toho ze je vytvorena instancia daneho objektu
    user=AdminUser.find_by_username(username)
    if user && user.password_match?(password)
      return user
    else
      return false
    end
  end  
  def self.hash_with_salt(password="", salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end
  def self.make_salt(username="")
    Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make the salt")
  end
  private # privátne metódy, ktoré môžu byť volané len v rámci tohoto Class
  def create_hashed_password
    unless password.blank?
      #always use "self" when assigning values
      self.salt=AdminUser.make_salt(username) if salt.blank?
      self.hashed_password=AdminUser.hash_with_salt(password, salt)
    end
  end
  def clear_password
    self.password=nil
  end
end
