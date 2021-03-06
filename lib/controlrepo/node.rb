require 'controlrepo'

class Controlrepo
  class Node
    @@all = []


    attr_accessor :name
    attr_accessor :beaker_node
    attr_accessor :fact_set

    def initialize(name)
      @name = name
      @beaker_node = nil

      # If we can't find the factset it will fail, so just catch that error and ignore it
      begin
        @fact_set = Controlrepo.facts[(Controlrepo.facts_files.index{|facts_file| File.basename(facts_file,'.json') == name})]
      rescue TypeError
        @fact_set = nil
      end
      @@all << self

    end

    def self.find(node_name)
      @@all.each do |node|
        if node_name.is_a?(Controlrepo::Node)
          if node = node_name
            return node
          end
        elsif node.name == node_name
          return node
        end
      end
      nil
    end

    def self.all
      @@all
    end
  end
end