require 'httparty'
require 'xmlsimple'
require 'awesome_print'

class BGG
  include HTTParty
  base_uri 'www.boardgamegeek.com/xmlapi'

  def geeklist(id)
    self.class.get("/geeklist/#{id}")
  end
end

class GeeklistsController < ApplicationController

  # GET /geeklists/123
  # GET /geeklists/123.json
  def show
    @geeklist_id = params[:id]

    bgg = BGG.new
    @geeklist = bgg.geeklist(@geeklist_id)["geeklist"]
  end
end

