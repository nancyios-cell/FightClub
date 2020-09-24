//
//  ApiModels.swift
//  FightClub
//
//  Created by APPLE on 23/09/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import Foundation


class BaseApiResponse : NSObject {
    var status_code      = 0
    var status_message     = ""
    
    init(object:[String:AnyObject]) {
        status_code = object["status_code"] as! Int
        status_message = object["status_message"] as! String
    }

}
//MARK: MovieListResponse -
/*
 "results": [
 {
 "popularity": 1526.825,
 "vote_count": 1875,
 "video": false,
 "poster_path": "/aKx1ARwG55zZ0GpRvU2WrGrCG9o.jpg",
 "id": 337401,
 "adult": false,
 "backdrop_path": "/zzWGRw277MNoCs3zhyG3YmYQsXv.jpg",
 "original_language": "en",
 "original_title": "Mulan",
 "genre_ids": [
 28,
 12,
 18,
 14,
 10752
 ],
 "title": "Mulan",
 "vote_average": 7.5,
 "overview": "When the Emperor of China issues a decree that one man per family must serve in the Imperial Chinese Army to defend the country from Huns, Hua Mulan, the eldest daughter of an honored warrior, steps in to take the place of her ailing father. She is spirited, determined and quick on her feet. Disguised as a man by the name of Hua Jun, she is tested every step of the way and must harness her innermost strength and embrace her true potential.",
 "release_date": "2020-09-10"
 },]
 */

class MovieListResponse: NSObject {
    var results = [Movie]()
    var page = 0
    var total_results = 0
    var total_pages = 0
    
    
     init(object:[String:AnyObject]) {
        //super.init(object: object)
        for dict in object["results"] as! [[String: AnyObject]]{
            let data2 = Movie.init(object: dict)
            results.append(data2)
        }
        page = object["page"] as! Int
        total_results = object["total_results"] as! Int
        total_pages = object["total_pages"] as! Int
        
    }
//    required init?(map:Map) {
//    }
//
//    func mapping(map: Map) {
//        self.results  <- map["results"]
//        self.page  <- map["page"]
//        self.total_results  <- map["total_results"]
//        self.total_pages  <- map["total_pages"]
//    }
    
}

class Movie: NSObject {
     var popularity = 0.0
     var vote_count = 0
     var video = false
     var poster_path = ""
     var id = 0
     var adult = false
     var backdrop_path = ""
     var original_language = ""
     var original_title = ""
     var title = ""
     var vote_average = 0.0
     var overview = ""
     var release_date = ""
    
    
    init(object:[String: AnyObject]) {
        popularity = object["popularity"] as! Double
        vote_count = object["vote_count"] as! Int
        video = object["video"] as! Bool
        poster_path  = object["poster_path"] as! String
        id = object["id"] as! Int
        adult = object["adult"] as! Bool
        title = object["title"] as! String
        backdrop_path = object["backdrop_path"] as! String
        original_language = object["original_language"] as! String
        original_title = object["original_title"] as! String
        title = object["title"] as! String
        vote_average = object["vote_average"] as! Double
        overview = object["overview"] as! String
        release_date = object["release_date"] as! String
    }
    
    //    override static func primaryKey() -> String? {
    //        return "id"
    //    }
    
//    func mapping(map: Map) {
//        self.popularity  <- map["popularity"]
//        self.vote_count  <- map["vote_count"]
//        self.video  <- map["video"]
//        self.poster_path  <- map["poster_path"]
//        self.id  <- map["id"]
//        self.adult  <- map["adult"]
//        self.backdrop_path  <- map["backdrop_path"]
//        self.original_language  <- map["original_language"]
//        self.original_title  <- map["original_title"]
//        self.title  <- map["title"]
//        self.vote_average  <- map["vote_average"]
//        self.overview  <- map["overview"]
//        self.release_date  <- map["release_date"]
//    }
    
}


//MARK: - Movie Id Response -
/*  {
  "adult": false,
  "backdrop_path": "/rr7E0NoGKxvbkb89eR1GwfoYjpA.jpg",
  "belongs_to_collection": null,
  "budget": 63000000,
  "genres": [
    {
      "id": 18,
      "name": "Drama"
    }
  ],
  "homepage": "http://www.foxmovies.com/movies/fight-club",
  "id": 550,
  "imdb_id": "tt0137523",
  "original_language": "en",
  "original_title": "Fight Club",
  "overview": "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
  "popularity": 41.087,
  "poster_path": "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
  "production_companies": [
    {
      "id": 508,
      "logo_path": "/7PzJdsLGlR7oW4J0J5Xcd0pHGRg.png",
      "name": "Regency Enterprises",
      "origin_country": "US"
    },
    {
      "id": 711,
      "logo_path": "/tEiIH5QesdheJmDAqQwvtN60727.png",
      "name": "Fox 2000 Pictures",
      "origin_country": "US"
    },
    {
      "id": 20555,
      "logo_path": "/hD8yEGUBlHOcfHYbujp71vD8gZp.png",
      "name": "Taurus Film",
      "origin_country": "DE"
    },
    {
      "id": 54051,
      "logo_path": null,
      "name": "Atman Entertainment",
      "origin_country": ""
    },
    {
      "id": 54052,
      "logo_path": null,
      "name": "Knickerbocker Films",
      "origin_country": "US"
    },
    {
      "id": 25,
      "logo_path": "/qZCc1lty5FzX30aOCVRBLzaVmcp.png",
      "name": "20th Century Fox",
      "origin_country": "US"
    },
    {
      "id": 4700,
      "logo_path": "/A32wmjrs9Psf4zw0uaixF0GXfxq.png",
      "name": "The Linson Company",
      "origin_country": ""
    }
  ],
  "production_countries": [
    {
      "iso_3166_1": "DE",
      "name": "Germany"
    },
    {
      "iso_3166_1": "US",
      "name": "United States of America"
    }
  ],
  "release_date": "1999-10-15",
  "revenue": 100853753,
  "runtime": 139,
  "spoken_languages": [
    {
      "iso_639_1": "en",
      "name": "English"
    }
  ],
  "status": "Released",
  "tagline": "Mischief. Mayhem. Soap.",
  "title": "Fight Club",
  "video": false,
  "vote_average": 8.4,
  "vote_count": 20104
}*/
class MovieIdResponse: NSObject {
    var genres = [Genres]()
    var id = 0
    var spoken_languages = [Spoken_Language]()
    var status = ""
    var vote_average = 0.0
    var title = ""
    var release_date = ""

    
     init(object:[String:AnyObject]) {
       // super.init(object: object)
        for dict in object["genres"] as! [[String: AnyObject]]{
            let data2 = Genres.init(object: dict)
            genres.append(data2)
        }
        for dict in object["spoken_languages"] as! [[String: AnyObject]]{
            let data2 = Spoken_Language.init(obj: dict)
            spoken_languages.append(data2)
        }

        id = object["id"] as! Int
        status = object["status"] as! String
        vote_average = object["vote_average"] as! Double
        title = object["title"] as! String
        release_date = object["release_date"] as! String

    }

}

class Genres: NSObject {
    var id = 0
    var name = ""

    init(object:[String: AnyObject]) {
        id = object["id"] as! Int
        name = object["name"] as! String
    }
}

/*
 "spoken_languages": [
  {
    "iso_639_1": "en",
    "name": "English"
  }
],
*/
class Spoken_Language : NSObject {
    var iso_639_1 = ""
    var name = ""
   
    init(obj:[String: AnyObject]) {
        iso_639_1 = obj["iso_639_1"] as! String
        name = obj["name"] as! String
    }

}


//MARK: - Movie Review -
/*
 "id": 550,
 "page": 1,
 "results": [
   {
     "author": "Goddard",
     "content": "Pretty awesome movie.  It shows what one crazy person can convince other crazy people to do.  Everyone needs something to believe in.  I recommend Jesus Christ, but they want Tyler Durden.",
     "id": "5b1c13b9c3a36848f2026384",
     "url": "https://www.themoviedb.org/review/5b1c13b9c3a36848f2026384"
   },

 */
class MovieReviewResponse : NSObject {
    var id = 0
    var results = [Review]()
    
     init(object:[String:AnyObject]) {
        //super.init(object: object)
        for dict in object["results"] as! [[String: AnyObject]]{
            let data2 = Review.init(obj: dict)
            results.append(data2)
        }
        id = object["id"] as! Int
    }

}

class Review: NSObject {
    var author = ""
    var content = ""
   
    init(obj:[String: AnyObject]) {
        author = obj["author"] as! String
        content = obj["content"] as! String
    }

}


// MARK: Movie Credits -
/*   "id": 550,
"cast": [
  {
    "cast_id": 4,
    "character": "The Narrator",
    "credit_id": "52fe4250c3a36847f80149f3",
    "gender": 2,
    "id": 819,
    "name": "Edward Norton",
    "order": 0,
    "profile_path": "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg"
  },
*/
class MovieCreditResponse: NSObject {
    var id = 0
    var cast = [Credit]()
    
     init(object:[String:AnyObject]) {
       // super.init(object: object)
        for dict in object["cast"] as! [[String: AnyObject]]{
            let data2 = Credit.init(object: dict)
            cast.append(data2)
        }
        id = object["id"] as! Int
    }

}

class Credit : NSObject {
    var cast_id = 0
    var character = ""
    var name = ""
    
    init(object:[String:AnyObject]) {
        cast_id = object["cast_id"] as! Int
        character = object["character"] as! String
        name = object["name"] as! String
    }
}


//MARK: - Similar Movie -
/*
 "results": [
   {
     "adult": false,
     "backdrop_path": "/keblhZFIZYiWflmURWNHEuS2jqL.jpg",
     "genre_ids": [
       878,
       18
     ],
     "id": 185,
     "original_language": "en",
     "original_title": "A Clockwork Orange",
     "overview": "In a near-future Britain, young Alexander DeLarge and his pals get their kicks beating and raping anyone they please. When not destroying the lives of others, Alex swoons to the music of Beethoven. The state, eager to crack down on juvenile crime, gives an incarcerated Alex the option to undergo an invasive procedure that'll rob him of all personal agency. In a time when conscience is a commodity, can Alex change his tune?",
     "poster_path": "/4sHeTAp65WrSSuc05nRBKddhBxO.jpg",
     "release_date": "1971-12-19",
     "title": "A Clockwork Orange",
     "video": false,
     "vote_average": 8.2,
     "vote_count": 8712,
     "popularity": 30.615
   },
 */

class MovieSimilarResponse : NSObject {
    var results = [SimilarMovie]()
    
     init(object:[String:AnyObject]) {
        //super.init(object: object)
        for dict in object["results"] as! [[String: AnyObject]]{
            let data2 = SimilarMovie.init(object: dict)
            results.append(data2)
        }
    }

}

class SimilarMovie : NSObject {
    var id = 0
    var title = ""
    var poster_path = ""
    
    init(object:[String:AnyObject]) {
        id = object["id"] as! Int
        title = object["title"] as! String
        poster_path = object["poster_path"] as! String
    }

}
