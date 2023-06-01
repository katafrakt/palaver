module RSpecHelpers
  module ClassMethods
    def stub(container, key, &block)
      around :each do |example|
        container.stub(key, instance_exec(&block)) { example.run }
      end
    end
  end

  module InstanceMethods
    def category_slug(category)
      Discussion::Utils::Slugger.new.to_slug(Discussion::Entities::Category::HASHIDS_NUM, category.name, category.id)
    end

    def thread_slug(thread)
      Discussion::Utils::Slugger.new.to_slug(Discussion::Entities::Thread::HASHIDS_NUM, thread.title, thread.id)
    end
  end
end
