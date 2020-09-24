//
//  WebServices.swift
//  FightClub
//
//  Created by APPLE on 23/09/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import Foundation
let api_Key = "e2a604c95e0c2fdc3c4f538a9cea2bd7"
let BASE_URL = "https://api.themoviedb.org/3/movie/"


class WebServices
{
    static let sharedInstance : WebServices = {
        return WebServices()
    }()
    
    /*
     Check Internet status whether it is Connected or not.
     **/
    public func checkInternet() -> Bool
    {
        let status = CheckInternetStatus().connectionStatus()
        switch status {
        case .unknown, .offline:
            return false
        case .online(.wwan), .online(.wiFi):
            return true
        }
    }

    func getMovieList(completionHandler:@escaping (_ success:Bool, _ movieResponse:MovieListResponse?) -> Void) {
        if checkInternet() {
            var mainUrl = ""
            mainUrl = "\(BASE_URL)now_playing?api_key=\(api_Key)&language=en-US&page=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let sURL = URL(string: mainUrl)!
            let request = URLRequest(url: sURL)
            let session = URLSession(configuration: URLSessionConfiguration.default)

            let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
                      // print(data)
                guard let data = data, error == nil else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
                   // print(json)
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 200 {
                            let obj = MovieListResponse.init(object: json)
                            completionHandler(true, obj)
                        } else {
                            completionHandler(false, nil)
                            print("****No Movie Lists***")
                        }
                    }
                } catch let error as NSError {
                    completionHandler(false, nil)
                 }

                })
            task.resume()
        } else {
            print("No Internet Connection")
        }
    }
    
    func getMovieWithId(id: Int, completionHandler:@escaping (_ success:Bool, _ movieResponse:MovieIdResponse?) -> Void) {
    if checkInternet() {
        var mainUrl = ""
        //https://api.themoviedb.org/3/movie/550?api_key=e2a604c95e0c2fdc3c4f538a9cea2bd7&language=en-US
        mainUrl = "\(BASE_URL)\(id)?api_key=\(api_Key)&language=en-US".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let sURL = URL(string: mainUrl)!
        let request = URLRequest(url: sURL)
        let session = URLSession(configuration: URLSessionConfiguration.default)

        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                //print(json)
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        let obj = MovieIdResponse.init(object: json)
                        completionHandler(true, obj)
                    }
                } else {
                    completionHandler(false, nil)
                }


            } catch let error as NSError {
                completionHandler(false, nil)
             }
        })
        task.resume()
        } else {
            print("No Internet Connection")
        }

    }
    
    
    func getMovieReview(id: Int, completionHandler:@escaping (_ success:Bool, _ movieResponse:MovieReviewResponse?) -> Void) {
        if checkInternet() {
              var mainUrl = ""
              //550/reviews?api_key=e2a604c95e0c2fdc3c4f538a9cea2bd7&language=en-US&page=1

              mainUrl = "\(BASE_URL)\(id)/reviews?api_key=\(api_Key)&language=en-US&page=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
              let sURL = URL(string: mainUrl)!
              let request = URLRequest(url: sURL)
              let session = URLSession(configuration: URLSessionConfiguration.default)

              let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
                  do {
                      let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                      //print(json)
                      if let httpResponse = response as? HTTPURLResponse {
                          if httpResponse.statusCode == 200 {
                            let obj = MovieReviewResponse.init(object: json)
                            completionHandler(true, obj)
                          } else {
                            completionHandler(false, nil)
                        }
                    }

                  } catch let error as NSError {
                      completionHandler(false, nil)
                   }
              })
              task.resume()
        } else {
            print("No Internet Connection")
        }
    }
    
    
    func getMovieCast(id: Int, completionHandler:@escaping (_ success:Bool, _ movieResponse:MovieCreditResponse?) -> Void) {
        if checkInternet() {
        var mainUrl = ""
        //550/credits?api_key=e2a604c95e0c2fdc3c4f538a9cea2bd7
        mainUrl = "\(BASE_URL)\(id)/credits?api_key=\(api_Key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let sURL = URL(string: mainUrl)!
        let request = URLRequest(url: sURL)
        let session = URLSession(configuration: URLSessionConfiguration.default)

        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                //print(json)
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        let obj = MovieCreditResponse.init(object: json)
                        completionHandler(true, obj)
                    } else {
                        completionHandler(false, nil)
                    }
                }
            } catch let error as NSError {
                completionHandler(false, nil)
             }
        })
        task.resume()
        } else {
            print("No Internet Connection")
        }

    }
    
    
    
    func getSimilarMovie(id: Int, completionHandler:@escaping (_ success:Bool, _ movieResponse:MovieSimilarResponse?) -> Void) {
        if checkInternet() {
        var mainUrl = ""
        //similar?api_key=e2a604c95e0c2fdc3c4f538a9cea2bd7&language=en-US&page=1

        mainUrl = "\(BASE_URL)\(id)/similar?api_key=\(api_Key)&language=en-US&page=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let sURL = URL(string: mainUrl)!
        let request = URLRequest(url: sURL)
        let session = URLSession(configuration: URLSessionConfiguration.default)

        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                //print(json)
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        let obj = MovieSimilarResponse.init(object: json)
                        completionHandler(true, obj)
                    } else {
                        completionHandler(false, nil)
                    }
                }

            } catch let error as NSError {
                completionHandler(false, nil)
             }
        })
        task.resume()
        } else {
            print("No Internet Connection")
        }

    }
}
