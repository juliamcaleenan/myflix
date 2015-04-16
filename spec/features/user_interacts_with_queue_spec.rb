require 'spec_helper'

feature "user interacts with queue" do
  scenario "user adds and reorders videos in queue" do

    category = Fabricate(:category)
    family_guy = Fabricate(:video, title: "Family Guy", category: category)
    futurama = Fabricate(:video, title: "Futurama", category: category)
    south_park = Fabricate(:video, title: "South Park", category: category)

    sign_in

    add_video_to_queue(family_guy)
    expect(page).to have_content family_guy.title

    click_link family_guy.title
    expect(page).to_not have_content "+ My Queue"

    add_video_to_queue(futurama)
    add_video_to_queue(south_park)

    set_video_position(family_guy, 3)
    set_video_position(futurama, 1)
    set_video_position(south_park, 2)

    click_button "Update Instant Queue"

    expect_video_position(futurama, 1)
    expect_video_position(south_park, 2)
    expect_video_position(family_guy, 3)
    
  end

  def add_video_to_queue(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click
    click_link "+ My Queue"
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][position]", with: position
    end
  end

  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
  end
end