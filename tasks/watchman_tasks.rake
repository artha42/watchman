namespace :watchman do
  desc "Import plugin assets to the public folder"
  task :sync_public do
    system 'rsync -truv vendor/plugins/watchman/public/ public'
  end
end
