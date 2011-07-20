# -*- encoding : utf-8 -*-
class MetawelcomeController < ApplicationController
  def team
  end

  def contact
  end

  def faq
  end

  def traffic
	  redirect_to 'http://192.168.145.253:8080/awstats/awstats.pl' and return
  end

end
