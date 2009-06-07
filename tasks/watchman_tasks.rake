namespace :watchman do
  desc "Import plugin assets to the public folder"
  task :sync_public do
    system 'rsync -tuv vendor/plugins/watchman/public .'
  end
end
