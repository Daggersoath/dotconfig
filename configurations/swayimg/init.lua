-- Bind the Delete key in standard viewing mode
swayimg.viewer.on_key("Delete", function()
    local image = swayimg.viewer.get_image()
    if image then
        os.remove(image.path)          -- Deletes file from your hard drive
        -- swayimg.viewer.skip_file()     -- Skips to the next image in the queue
    end
end)

-- Map left key to previous image
swayimg.viewer.on_key("Left", function()
    swayimg.viewer.open("prev")
end)

-- Map right key to next image
swayimg.viewer.on_key("Right", function()
    swayimg.viewer.open("next")
end)

-- swayimg.text.hide()
swayimg.text.visible = false
