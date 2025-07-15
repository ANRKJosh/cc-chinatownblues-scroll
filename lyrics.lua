--[[
  Chinatown Blues - Lyric Scroller (for Advanced Monitors)
  By Vended
 
  This program displays the lyrics to the song "Chinatown Blues"
  on an attached advanced monitor with a scrolling effect. The timing
  of each line is approximated to match the song's rhythm.
 
  This version features larger text and splits long lines to fit
  better on monitors.
 
  Instructions:
  1. Place an Advanced Monitor next to the ComputerCraft computer.
  2. Save this code as a new program on the computer (e.g., "lyrics").
  3. Run the program by typing its name in the terminal.
  4. The lyrics will start scrolling on the monitor. To stop, press Ctrl+T.
--]]

-- Find the first available monitor attached to the computer.
local monitor = peripheral.find("monitor")

-- If no monitor is found, print an error to the local terminal and stop.
if not monitor then
  print("Error: No monitor found.")
  print("Please attach an Advanced Monitor to any side of the computer.")
  return
end

-- Set the text scale to make it larger. Default is 1.
-- You can change this value (e.g., to 2 for even larger text).
monitor.setTextScale(1.5)

-- Table of lyrics with their display timings.
-- Delays have been adjusted to match the video timings.
-- Note: Timings are calculated based on the start of each line group.
local lyrics = {
  { text = "Headlights, your Mustang witnessed", delay = 3.3 },
  { text = "as we're eye to eye", delay = 3.4 },
  { text = "Tell me why, your lack of intuition", delay = 3.4 },
  { text = "burns me white", delay = 3.2 },
  { text = "Only you can make me burn just like the sun", delay = 7.0 },
  { text = "Only you can piece me back to one", delay = 6.5 },
  { text = "", delay = 1.0 },
  { text = "No matter what you do, I'll stay", delay = 3.2 },
  { text = "This isn't up to you today", delay = 3.0 },
  { text = "It hasn't always been this way", delay = 3.0 },
  { text = "I've got a lot to prove today", delay = 2.8 },
  { text = "", delay = 1.0 },
  { text = "Oh I'll never go", delay = 1.6 },
  { text = "I'll stay", delay = 1.4 },
  { text = "I wanna hold you close", delay = 1.8 },
  { text = "Today", delay = 1.3 },
  { text = "I won't let you go", delay = 1.7 },
  { text = "This way", delay = 1.4 },
  { text = "Come on, let's give 'em a show", delay = 2 },
  { text = "Today", delay = 1.3 },
  { text = "", delay = 1.4 },
  { text = "Roll the dice", delay = 2.5 },
  { text = "Let's see how far you'll push", delay = 2.4 },
  { text = "my nerves this time", delay = 2.4 },
  { text = "Heavy sigh I always lose", delay = 3.8 },
  { text = "when you apologize", delay = 3.6 },
  { text = "Only you can make me burn just like the sun", delay = 5.0 },
  { text = "Only you can fix me when I'm undone", delay = 4.5 },
  { text = "", delay = 1.0 },
  { text = "No matter what you do, I'll stay", delay = 3.2 },
  { text = "This isn't up to you today", delay = 3.1 },
  { text = "It hasn't always been this way", delay = 3.3 },
  { text = "I've got a lot to prove today", delay = 3.2 },
  { text = "", delay = 1.2 },
  { text = "I'll stay", delay = 2.3 },
  { text = "Today", delay = 2.3 },
  { text = "This way", delay = 2.3 },
  { text = "Today", delay = 3.0 },
  { text = "", delay = 2.0 },
  { text = "Even if you let me go...", delay = 2.2 },
  { text = "I'll stay", delay = 2.2 },
  { text = "I want hold you close...", delay = 2.2 },
  { text = "Today", delay = 2.2 },
  { text = "I want to keep feeling...", delay = 2.2 },
  { text = "This way", delay = 2.2 },
  { text = "I want to keep loving,", delay = 1.8 },
  { text = "and loving...", delay = 1.2 },
  { text = "Today", delay = 3.0},
  { text = "", delay = 1.0 },
  { text = "No matter what you do, I'll stay", delay = 2.75 },
  { text = "This isn't up to you today", delay = 2.75 },
  { text = "It hasn't always been this way", delay = 2.75 },
  { text = "I've got a lot to prove today", delay = 2.75 },
  { text = "", delay = 2.0 },
  { text = "Headlights, your Mustang witnessed", delay = 3.0 },
  { text = "me embrace you tight", delay = 3.0 },
  { text = "(Today)", delay = 1.2},
  { text = "Hazy eyes, I think I'll pass out", delay = 3.0 },
  { text = "(This way)", delay = 1.5 },
  { text = "in your arms tonight", delay = 3.0 },
  { text = "Today", delay = 1.2},
}

-- Function to clear the monitor screen and set the cursor to the top
local function clearScreen()
  monitor.clear()
  monitor.setCursorPos(1, 1)
end

-- Function to center and print text on a specific line on the monitor
local function printCentered(y, text)
  local screenWidth, _ = monitor.getSize()
  local x = math.floor((screenWidth - #text) / 2) + 1
  monitor.setCursorPos(x, y)
  monitor.write(text)
end

-- Main function to run the scrolling display
local function run()
  local _, screenHeight = monitor.getSize()
  local displayLines = {} -- This table holds the lines currently on screen

  -- Initialize the display with blank lines
  for i = 1, screenHeight do
    table.insert(displayLines, "")
  end

  -- Loop through each lyric in the song
  for i = 1, #lyrics do
    local line = lyrics[i]

    -- Add the new lyric to the bottom of the display buffer
    table.insert(displayLines, line.text)
    -- Remove the top line to create the scrolling effect
    table.remove(displayLines, 1)

    -- Redraw the entire screen
    clearScreen()
    for j = 1, screenHeight do
      printCentered(j, displayLines[j])
    end

    -- Wait for the specified delay for this lyric
    sleep(line.delay)
  end

  -- Keep the last screen of lyrics visible for a moment
  sleep(5)
  clearScreen()
  printCentered(math.floor(screenHeight / 2), "END")
  sleep(2)
  clearScreen()
end

-- Start the program
-- First, clear the computer's own terminal so it's clean.
term.clear()
term.setCursorPos(1,1)
print("Starting lyric display on monitor...")
run()
print("Program finished.")
