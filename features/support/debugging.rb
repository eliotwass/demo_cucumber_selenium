# `STEP=1 cucumber` to pause after each step
AfterStep do |scenario|
  next unless ENV['STEP']
  unless defined?(@counter)
    puts "Stepping through #{scenario.title}"
    @counter = 0
  end
  @counter += 1
  print "At step ##{@counter} of #{scenario.steps.count}. Press Return to"\
        ' execute...'
  STDIN.getc
end