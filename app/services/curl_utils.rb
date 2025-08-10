require "httparty"
require "shellwords"

class CurlUtils
  # High-level method to handle raw curl command
  def self.call_curl_command(curl_command)
    parsed = parse_curl_command(curl_command)
    call_curl(parsed[:url], method: parsed[:method], headers: parsed[:headers], body: parsed[:body])
  end

  # Executes the HTTP request using HTTParty
  def self.call_curl(url, method: :get, headers: {}, body: nil)
    response = HTTParty.send(method.to_sym, url, headers: headers, body: body)
    if response.success?
      response
    else
      raise "HTTP request failed with status code #{response.code}: #{response.message}"
    end
  rescue StandardError => e
    raise "An error occurred while making the HTTP request: #{e.message}"
  end

  # Parses a full curl command string into URL, method, headers, and body
  def self.parse_curl_command(curl_command)
    args = Shellwords.shellsplit(curl_command)

    raise "Not a curl command" unless args.first == "curl"

    method = :get
    headers = {}
    body_parts = []
    url = nil

    i = 1
    while i < args.length
      case args[i]
      when "-X", "--request"
        method = args[i + 1].downcase.to_sym
        i += 1
      when "-H", "--header"
        key, value = args[i + 1].split(":", 2).map(&:strip)
        headers[key] = value
        i += 1
      when "-d", "--data", "--data-raw", "--data-binary", "--data-urlencode"
        body_parts << args[i + 1]
        method = :post if method == :get  # assume POST if data exists and method wasn't set
        i += 1
      when "--url"
        url = args[i + 1]
        i += 1
      when "-L", "--location"
        # auto-redirect not supported directly in HTTParty
        # could be extended with follow_redirects logic
      when "--compressed"
        headers["Accept-Encoding"] ||= "deflate, gzip"
      when "--insecure", "-k"
        # ignore SSL verification - not handled in HTTParty directly
        # could be used with `verify: false` if using other HTTP clients
      else
        # fallback to get URL if matches http(s)
        url ||= args[i] if args[i] =~ /\Ahttps?:\/\//
      end
      i += 1
    end

    raise "URL not found in curl command" unless url

    {
      url: url,
      method: method,
      headers: headers,
      body: body_parts.any? ? body_parts.join("&") : nil
    }
  end
end
