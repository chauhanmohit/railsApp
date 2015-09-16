require 'soda/client'
class ApiHandelerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    respond_to do |format|
      format.json # index.html.erb
    end
  end
  
  def data
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
        #if stale? last_modified: updated_at, etag: etag
        #  render json: @response
        #end  
    else
      @message ='{ "Error": { "status":400 , "message":"Please Specifiy the location co-ordinates and data limit" } }'
      respond_to do |format|
        format.json { render :json => @message }
      end 
    end
  end
  
  def getlistViewContent
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
                              {
                              "$where" => "within_circle(location, #{@lat}, #{@lang}, #{@radius}) AND
                                           date > '#{@from}' AND date < '#{@to}' And
                                           (primary_type = '#{crimeType[0]}' OR primary_type = '#{crimeType[1]}'
                                             OR primary_type = '#{crimeType[2]}' OR primary_type = '#{crimeType[3]}'
                                            )",
                              "$limit"=>"1200",
                              "arrest"=>"#{@arrest}",
                              }
                            )
      #"$select" => "arrest,case_number,date,description,location_description,latitude, longitude, primary_type, id",
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
  
  def mobileData
    headers['Access-Control-Allow-Origin'] = '*'
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
