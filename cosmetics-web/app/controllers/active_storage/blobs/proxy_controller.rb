# frozen_string_literal: true

# Proxy files through application. This avoids having a redirect and makes files easier to cache.
class ActiveStorage::Blobs::ProxyController < ActiveStorage::BaseController
  include ActiveStorage::SetBlob
  include ActiveStorage::SetHeaders
  include Pundit
  include DomainConcern

  before_action :authorize_blob

  def show
    binding.pry
    # http_cache_forever public: true do
      set_content_headers_from @blob
      stream @blob
    # end
  end

  private

  def pundit_user
    current_submit_user
  end

  def authorize_blob
    if submit_domain?
      authenticate_submit_user!

      rp = @blob.attachments.first.record.notification.responsible_person
      authorize rp, :show?
    else
      authenticate_search_user!
    end
  end
end
