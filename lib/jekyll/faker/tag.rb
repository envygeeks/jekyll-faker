# Frozen-string-literal: true
# Copyright: 2017 - Apache 2.0 License
# Encoding: utf-8

require "liquid/tag/parser"
require_relative "version"
require "faker"

module Jekyll
  module Faker
    class Tag < Liquid::Block
      public_class_method :new

      # --
      # @return [String]
      # rubocop:disable Layout/SpaceInsideStringInterpolation
      # Render the tag, run the proxies, set the defaults.
      # @note Defaults are ran twice just incase the content type
      #   changes, at that point there might be something that
      #   has to change in the new content.
      # --
      def render(ctx)
        args = Liquid::Tag::Parser.new(@markup)
        fakr = discover(camelize(args[:argv1]))

        out = ""
        args.each do |k, v|
          next if k == :argv1

          begin
            result = fakr.send(k, *Array(v))
            Array(result).each do |sv|
              ctx["faker"] = {
                "val" => sv,
              }

              out += super
            end
          rescue NoMethodError => e
            handle_missing_faker_method(e, {
              args: args,
            })
          end
        end

        out
      end

      # --
      def handle_missing_faker_method(e, args:)
        if e.message =~ %r!Faker!i
          raise ArgumentError, "Unknown faker #{
            args[:argv1]
          }"
        else
          raise e
        end
      end

      # --
      # rubocop:disable Style/PerlBackrefs.
      # @return [String] the camelized name of the runner.
      # Camelize the name of the class.
      # --
      private
      def camelize(arg)
        arg.to_s.capitalize.gsub(%r!(?:-)([a-z]*)!) do
          $1.capitalize
        end
      end

      # --
      private
      def discover(const)
        return ArgumentError, "No Faker given" unless const
        ::Faker.const_defined?(const) ? ::Faker.const_get(const) : \
          matched_discovery(const)
      rescue NameError
        raise ArgumentError, "Invalid Faker: #{
          const
        }"
      end

      # --
      private
      def matched_discovery(const)
        regexp = %r!^#{Regexp.escape(const)}$!i

        out = ::Faker.constants.grep(regexp)
        raise ArgumentError, "Bad argv1 #{const}" if out.size > 1
        raise NameError if out.none?
        ::Faker.const_get(out.first)
      end
    end
  end
end

# --
Liquid::Template.register_tag "faker", Jekyll::Faker::Tag
