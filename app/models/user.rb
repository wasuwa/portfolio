class User < ApplicationRecord
    validates :name, presence: true, length: { maximunm: 8 }
end
