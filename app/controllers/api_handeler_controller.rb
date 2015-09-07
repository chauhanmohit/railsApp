require 'soda/client'
class ApiHandelerController < ApplicationController
  skip_before_action :verify_authenticity_token
  #caches_page :index, :mobileData
  
  def initialize()
      @view_uid = "6zsd-86xi";
      @root_url = "data.cityofchicago.org";
      @app_token = "v1SkHrbzQcyFmlkL9D5W1UXfT";
  end

  def index
    @lat = params[:lat]
    @lang = params[:lang]
    @radius = params[:radius]
    @from = params[:from]
    @to = params[:to]
    @type = params[:type]
    @arrest = params[:arrest]
    crimeType = params[:type].split(',')
  
    if @lat && @lang && @radius
      client = SODA::Client.new({ :domain => 'data.cityofchicago.org', :app_token => 'v1SkHrbzQcyFmlkL9D5W1UXfT' })
      @response = client.get('6zsd-86xi',
                              {"$select" => "arrest,case_number,date,description,location_description,latitude, longitude, primary_type, id",
                              "$where" => "within_circle(location, #{@lat}, #{@lang}, #{@radius}) AND
                                           date > '#{@from}' AND date < '#{@to}' And
                                           (primary_type = '#{crimeType[0]}' OR primary_type = '#{crimeType[1]}'
                                             OR primary_type = '#{crimeType[2]}' OR primary_type = '#{crimeType[3]}'
                                            )",
                              "$limit"=>"1200",
                              "arrest"=>"#{@arrest}",
                              }
                            )
      respond_to do |format|
        format.json { render :json => @response }
      end 
    else
      @message ='{ "Error": { "status":400 , "message":"Please Specifiy the location co-ordinates and data limit" } }'
      respond_to do |format|
        format.json { render :json => @message }
      end 
    end
  end
  
  def getTableContent
    request.body.rewind
    req = JSON.parse request.body.read
    @lat = req['data']['lat']
    @lang = req['data']['lang']
    @radius = req['data']['radius']
    @from = req['data']['from']
    @to = req['data']['to']
    @type = req['data']['type']
    @arrest = req['data']['arrest']
  
    if @lat && @lang && @radius
      client = SODA::Client.new({ :domain => 'data.cityofchicago.org', :app_token => 'v1SkHrbzQcyFmlkL9D5W1UXfT' })
      response = client.get('6zsd-86xi',
                              {"$select" => "arrest,case_number,date,description,location_description,latitude, longitude, primary_type, id",
                              "$where" => "within_circle(location, #{@lat}, #{@lang}, #{@radius}) AND
                                           date > '#{@from}' AND date < '#{@to}' And
                                           (primary_type = '#{@type[0]}' OR primary_type = '#{@type[1]}'
                                             OR primary_type = '#{@type[2]}' OR primary_type = '#{@type[3]}'
                                            )",
                              "$limit"=>"1200",
                              "arrest"=>"#{@arrest}",
                              }
                            )
      respond_to do |format|
        format.json { render :json => response }
      end 
    else
      @message ='{ "Error": { "status":400 , "message":"Please Specifiy the location co-ordinates and data limit" } }'
      respond_to do |format|
        format.json { render :json => @message }
      end 
    end
  end
  
  def mobileData
    @lat = params[:lat]
    @lang = params[:lang]
    @radius = params[:radius]
    @from = params[:from]
    @to = params[:to]
    @type = params[:type]
    @arrest = params[:arrest]
    datalimit = params[:datalimit]
    crimeType = params[:type].split(',')
  
    if @lat && @lang && @radius
      client = SODA::Client.new({ :domain => 'data.cityofchicago.org', :app_token => 'v1SkHrbzQcyFmlkL9D5W1UXfT' })
      response = client.get('6zsd-86xi',
                              {
                              "$where" => "within_circle(location, #{@lat}, #{@lang}, #{@radius}) AND
                                           date > '#{@from}' AND date < '#{@to}' And
                                           (primary_type = '#{crimeType[0]}' OR primary_type = '#{crimeType[1]}'
                                             OR primary_type = '#{crimeType[2]}' OR primary_type = '#{crimeType[3]}'
                                            )",
                              "$limit"=>"#{datalimit}",
                              "arrest"=>"#{@arrest}",
                              }
                            )
      respond_to do |format|
        format.json { render :json => response }
      end 
    else
      @message ='{ "Error": { "status":400 , "message":"Please Specifiy the location co-ordinates and data limit" } }'
      respond_to do |format|
        format.json { render :json => @message }
      end 
    end
  end
  
end
