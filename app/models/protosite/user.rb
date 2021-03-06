module Protosite
  class User < Protosite.configuration.parent_record.constantize
    before_create :generate_authentication_token!

    validates :name, :email,
      presence: true
    validates :email,
      uniqueness: true

    has_secure_password

    attribute_schema :permissions do
      boolean :create_page, default: true
      boolean :publish_page, default: true
      boolean :remove_page, default: true
      boolean :update_self, default: true
    end

    private

      def generate_authentication_token!
        self.authentication_token ||= Digest::SHA1.hexdigest("#{Time.now}-#{id}-#{updated_at}-#{SecureRandom.hex}")
      end
  end
end
