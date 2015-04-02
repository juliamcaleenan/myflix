# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

comedies = Category.create(name: "TV Comedies")
dramas = Category.create(name: "TV Dramas")

monk = Video.create(title: "Monk", description: "Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg", category: dramas)
family_guy = Video.create(title: "Family Guy", description: "In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.", small_cover_url: "family_guy.jpg", large_cover_url: "monk_large.jpg", category: comedies)
futurama = Video.create(title: "Futurama", description: "Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999.", small_cover_url: "futurama.jpg", large_cover_url: "monk_large.jpg", category: comedies)
Video.create(title: "South Park", description: "Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.", small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg", category: comedies)
Video.create(title: "Monk", description: "Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg", category: dramas)
Video.create(title: "Family Guy", description: "In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.", small_cover_url: "family_guy.jpg", large_cover_url: "monk_large.jpg", category: comedies)
Video.create(title: "Futurama", description: "Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999.", small_cover_url: "futurama.jpg", large_cover_url: "monk_large.jpg", category: comedies)
Video.create(title: "South Park", description: "Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.", small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg", category: comedies)
Video.create(title: "Monk", description: "Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg", category: dramas)
Video.create(title: "Family Guy", description: "In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.", small_cover_url: "family_guy.jpg", large_cover_url: "monk_large.jpg", category: comedies)
Video.create(title: "Futurama", description: "Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999.", small_cover_url: "futurama.jpg", large_cover_url: "monk_large.jpg", category: comedies)
Video.create(title: "South Park", description: "Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.", small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg", category: comedies)

john = User.create(email_address: "johndoe@example.com", password: "password", full_name: "John Doe")
jane = User.create(email_address: "janedoe@example.com", password: "password", full_name: "Jane Doe")
bob = User.create(email_address: "bobsmith@example.com", password: "password", full_name: "Bob Smith")

Review.create(description: "Monk is one of the best new shows around. Tony Shalhoub plays Monk perfectly. Monk isn't your average detective. His wife was killed in a car explosion 3 year ago. He suffered a major breakdown and is now trying to get reinstated on the police force with the help of his private nurse. Monk's got lots of problems. He is Obsessive Compulsive, has fear of crowds, heights, the dark, and milk. Yes milk. Yet he is the greatest detective around. In one episode he even tried to straighten up the crime scene because the mess was driving him crazy.", rating: 5, user: john, video: monk)
Review.create(description: "It isn't often that a series on a cable network turns out to be the best new show of the season, but that is just what happened with Monk. It is off beat, delightfully acted and very humorously written. Monk, himself, is outrageous and unpredictable. The viewer never knows what Monk will find to obsess over. However he is as observant or even more so than Sherlock Holmes. Tony Shaloub is really great in bringing this difficult character to life. The whole cast is exactly right.", rating: 4, user: jane, video: monk)
Review.create(description: "Family Guy is actually one of my favorite shows, the jokes are always a blast to hear and watch and it has one of my all time favorite cartoon characters: Stewie Griffin. A lot of hard core Simpsons fans do accuse this show of being a rip off, I agree, it's similar in some aspects, but still Family Guy is always worth the watch in my opinion. It's also a little more grown up than other cartoons, when it comes to the hard core jokes, Family Guy never disappoints, they will take the joke as far as they can go.", rating: 4, user: john, video: family_guy)