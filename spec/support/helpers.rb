module RSpecHelpers
  def stub(container, key, &block)
    around :each do |example|
      container.stub(key, instance_exec(&block)) { example.run }
    end
  end
end
