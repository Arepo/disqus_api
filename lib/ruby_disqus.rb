require 'active_support/hash_with_indifferent_access'
require 'yaml'
require 'json'
require 'faraday'
require 'faraday_middleware'

require 'ruby_disqus/api'
require 'ruby_disqus/request'
require 'ruby_disqus/namespace'

module DisqusApi

  # @return [ActiveSupport::HashWithIndifferentAccess]
  def self.config
    @config || raise("No configuration specified for Disqus")
  end

  # @param [Hash] config
  # @option config [String] :api_secret
  # @option config [String] :api_key
  # @option config [String] :access_token
  def self.config=(config)
    @config = ActiveSupport::HashWithIndifferentAccess.new(config)
  end

  # @param [String] version
  # @return [Api]
  def self.init(version)
    Api.new(version, YAML.load_file(File.join(File.dirname(__FILE__), "apis/#{version}.yml")))
  end

  # @return [Api]
  def self.v3
    @v3 ||= init('3.0')
  end
end
