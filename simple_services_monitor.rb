require "net/http"
require "yaml"
require 'open-uri'

describe "Verifies services are up" do
  describe "Available Services:" do
    environments = ["development", "sqa", "uat", "staging", "production"]
    settings = YAML.load_file('config/settings.yml')

    def process_request(service, username=nil, key=nil)
      open(service, http_basic_authentication: [username, key], ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE)
    end

    environments.each do |env|
      it "XXXXXXXX ping_as_service in #{env} is UP" do
        url = "#{settings[env]['XXXXXXXX']['url']}/#{settings[env]['XXXXXXXX']['ping_route']}"
        username = settings[env]['XXXXXXXX']['username']
        key = settings[env]['XXXXXXXX']['key']
        response = process_request(url, username, key)
        response.status.first.should == "200"
        response.base_uri.to_s.should == url
      end
    end

    environments.each do |env|
      it "Upc Hierarchy Solr #{env} is UP" do
        search_settings = settings[env]['search']
        url = "#{search_settings['url']}/#{search_settings['upc_hierarchy_route']}"
        username = search_settings['username']
        key = search_settings['key']
        response = process_request(url, username, key)
        response.status.first.should == "200"
        response.base_uri.to_s.should == url
      end
    end

    environments.each do |env|
      it "Consumer Solr #{env} is UP" do
        search_settings = settings[env]['search']
        url = "#{search_settings['url']}/#{search_settings['retailer_total_baskets_route']}"
        username = search_settings['username']
        key = search_settings['key']
        response = process_request(url, username, key)
        response.status.first.should == "200"
        response.base_uri.to_s.should == url
      end
    end

    environments.each do |env|
      it "Events Solr #{env} is UP" do
        search_settings = settings[env]['search']
        url = "#{search_settings['url']}/#{search_settings['retailer_print_counts_route']}"
        username = search_settings['username']
        key = search_settings['key']
        response = process_request(url, username, key)
        response.status.first.should == "200"
        response.base_uri.to_s.should == url
      end
    end
  end
end