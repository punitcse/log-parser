# frozen_string_literal: true

module Parser
  # renders the page counts
  class View
    attr_reader :response

    def render(response, unique: false)
      response.each do |counter|
        render_line(counter[:page], counter[:count], unique: unique)
      end
    end

    private

    def render_line(page_name, count, unique: false)
      if unique
        puts "#{page_name} #{count} unique views"
      else
        puts "#{page_name} #{count} visits"
      end
    end
  end
end
