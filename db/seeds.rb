# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

names = %w[auto dovoz  kvety peter novinka s pre netreba a lebo ale samo sa slnko energie sila a moc tam spolu o kom preteky a je to zhoreli sa smiech zisk podnik peniaze tovar dovoz voda jazero dovolenku na aj oni vianoce kapor sviatok mandarinky sushi potok xenia lavica daj pomahaj lamem skoro sklo tenky tehla beton skalny trapny nosime len ich im jej ju mi ho mu laska]
pos = 0
10000.times do
  pos =+ 1
  Subject.create(
    :name         => names.shuffle[0..3].join(" ") ,
    :position     => pos , 
    :visible      => false 
    )
end