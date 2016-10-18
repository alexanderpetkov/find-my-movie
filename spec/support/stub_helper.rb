module Support
  module StubHelper
    def stub_elasticsearch
      elastic_url = ENV['ELASTICSEARCH_URL'] || 'http://localhost:9200'

      stub_request(:get, /#{elastic_url}.*/)
        .with(headers: {
                'Accept' => '*/*',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'User-Agent' => 'Faraday v0.9.2'
              })
        .to_return(status: 200, body: '{}',
                   headers: { 'Content-Type' => 'application/json' })
    end
  end
end
