Lablet = {
    interface = 1.0,
    title = "Demo 2: Motion analysis"
}


function Lablet.buildActivity(builder)

    -- SHEET 1
	local sheet = builder:create("Sheet")
	builder:add(sheet)
	sheet:setTitle("Stage 1 Physics Laboratory")
	sheet:addHeader("Lab equipment:")
	sheet:addText("Have you got the lab equipment? Check the following:")
	sheet:addCheckQuestion("a metre rule for setting the length scale in the video")
	sheet:addCheckQuestion("a ball")

    -- SHEET 2
	local sheet = builder:create("Sheet")
	builder:add(sheet)
	sheet:setMainLayoutOrientation("horizontal")
	sheet:setTitle("Take Videos:")
	local cameraExperiment1 = sheet:addCameraExperiment()
	cameraExperiment1:setDescriptionText("Please take a free fall video:")
	local experimentFreeFall = cameraExperiment1:getExperiment()
	local cameraExperiment2 = sheet:addCameraExperiment()
	cameraExperiment2:setDescriptionText("Please take an up/down video:")
	local experimentUpDown = cameraExperiment2:getExperiment()
	local cameraExperiment3 = sheet:addCameraExperiment()
	cameraExperiment3:setDescriptionText("Please take a projectile video:")
	local experimentProjectile = cameraExperiment3:getExperiment()

    -- SHEET 3
	local sheet = builder:create("Sheet")
	builder:add(sheet)
	sheet:setTitle("Info")
	sheet:addText("Check with your demonstrator about your videos and get ticked off before your proceed to video analysis.")
	sheet:addText("Video analysis: In this section, you and your lab partner will track the motion of the ball. For all three videos follow these steps:")
	sheet:addText("Go to \"Video Settings\". Set the start and end frames. For example, the free-fall video should start shortly before the ball leaves your hand and shortly after the ball hits the ground. Optionally, increase the frame rate to 15 or 30 frames per second. Click \"Apply\".")
	sheet:addText("Now drag the green length scale to fit your length reference. Click on \"Calibration\" and set scale. Click \"Apply\".")
	sheet:addText("You can now tag the positions of the ball from the initial position to the final position. Find the cross-hair with green rings, drag it by the outer ring to tag the ball and advance to the next frame. Repeat until you have finished tagging. Click “Done” to analyse other videos (e.g. vertical linear motion and projectile motion).")

	-- SHEET 4
	local sheet = builder:create("MotionAnalysis")
	builder:add(sheet)
	sheet:setTitle("Mark Data Points")
	sheet:setExperiment(experimentFreeFall)
	sheet:setDescriptionText("Please analyse the free fall video:")

	-- SHEET 5
	local sheet = builder:create("MotionAnalysis")
	builder:add(sheet)
	sheet:setTitle("Mark Data Points")
	sheet:setExperiment(experimentUpDown)
	sheet:setDescriptionText("Please analyse the up/down video:")

    -- SHEET 6
	local sheet = builder:create("MotionAnalysis")
	builder:add(sheet)
	sheet:setTitle("Mark Data Points")
	sheet:setExperiment(experimentProjectile)
	sheet:setDescriptionText("Please analyse the projectile video:")

	-- SHEET 7
	local sheet = builder:create("CalculateYSpeed")
	builder:add(sheet)
	sheet:setExperiment(experimentFreeFall)
	sheet:setTitle("Free fall")
	sheet:setHeader("Deriving average y-velocity and y-acceleration from displacement")

    -- SHEET 8
	local sheet = builder:create("Sheet")
	builder:add(sheet)
	sheet:setTitle("Free Fall")
	sheet:addHeader("Estimating impact velocity")
	sheet:addText("Go to your demonstrator once you finished answering the questions on this page:")

	local horizontalLayout = sheet:addHorizontalGroupLayout()

	sheet:addMotionAnalysisGraph(experimentFreeFall, horizontalLayout):showXVsYPosition()
	sheet:addMotionAnalysisGraph(experimentFreeFall, horizontalLayout):showTimeVsYSpeed()
	sheet:addQuestion("We know that moving objects have kinetic energy and that energy can be transferred from one form to the other. How did the ball gain kinetic energy?")
	sheet:addQuestion("Use the “Conservation of Energy” principle to estimate the impact velocity of the ball. How does it compare with your observed final velocity? If there is any difference, suggest the possible causes.")
	sheet:addCheckQuestion("Go to your demonstrator now and verify your results.")

	-- SHEET 9
	local sheet = builder:create("Sheet")
	builder:add(sheet)
	sheet:setTitle("Vertical linear motion")
	sheet:addHeader("Analysing graphs:")
	sheet:addText("Use the position-time graph and the velocity-time graph to complete the questions below.")

	local horizontalLayout = sheet:addHorizontalGroupLayout()
	local graph = sheet:addMotionAnalysisGraph(experimentUpDown, horizontalLayout)
	graph:setTitle("y-Position vs. Time")
	graph:setXAxisContent("time")
	graph:setYAxisContent("y-position")
	local graph = sheet:addMotionAnalysisGraph(experimentUpDown, horizontalLayout)
	graph:setTitle("y-Velocity vs. Time")
	graph:setXAxisContent("time_v")
	graph:setYAxisContent("y-velocity")
	sheet:addQuestion("How does the vertical velocity vary with time?")
	sheet:addQuestion("Point out on the height-time graph where the vertical velocity of the ball was the maximum and also where it was zero.")
	
	sheet:addHeader("Estimating Energy Input")
	sheet:addText("Complete the following questions:")
	local pbjQuestion = sheet:addPotentialEnergy1Question();
	pbjQuestion:setMassQuestionText("Please enter the mass of the ball:")
	pbjQuestion:setHeightQuestionText("What was the height of the ball at its peak?")
	pbjQuestion:setEnergyQuestionText("How much energy input enabled the ball to reach this height?")
	pbjQuestion:setPbjSandwichQuestionText("A typical peanut butter jam (PBJ) sandwich contains 432 calories. How many throws could you perform with one PBJ sandwich?\n(1 calorie = 4.184 J)");
	sheet:addCheckQuestion("Go to your demonstrator now and verify your results.")

	-- SHEET 10
	local sheet = builder:create("Sheet")
	builder:add(sheet)
	sheet:setTitle("Projectile Motion")
	sheet:addHeader("Analysing graphs")
	sheet:addText("The position-time graphs and the velocity-time graphs are created from your measurements. Use these graphs to complete the questions below.")
    local horizontalLayout = sheet:addHorizontalGroupLayout()
    sheet:addMotionAnalysisGraph(experimentProjectile, horizontalLayout):showXVsYPosition()
    sheet:addMotionAnalysisGraph(experimentProjectile, horizontalLayout):showTimeVsYSpeed()
	sheet:addQuestion("How does the vertical velocity vary with time?")
	sheet:addQuestion("How would you draw a free body diagram of the ball at the peak of the trajectory?")
	sheet:addQuestion("Compare the “vertical velocity-time” graphs of projectile motion, vertical linear motion and free fall. What are the similarities or the differences? (Hint: How does the direction of the moving ball affect the sign of velocity? Does the velocity vary or remain constant? Does the acceleration vary or remain constant?)")
	
	sheet:addHeader("Analysing the horizontal velocity in projectile motion")
	sheet:addMotionAnalysisGraph(experimentProjectile):showTimeVsXSpeed()
	sheet:addText("Use the “horizontal velocity-time” graph to answer the following question:")
	sheet:addQuestion("Does the horizontal velocity vary or remain constant? What about the horizontal acceleration?")

	sheet:addHeader("Estimating the horizontal and vertical accelerations")
	sheet:addQuestion("Using the velocity-time graphs, estimate the horizontal and vertical accelerations. How did you arrive to your estimates.")
	
	local horizontalLayout = sheet:addHorizontalGroupLayout()
	sheet:addMotionAnalysisGraph(experimentProjectile, horizontalLayout):showTimeVsXSpeed()
	sheet:addMotionAnalysisGraph(experimentProjectile, horizontalLayout):showTimeVsYSpeed()
	
	sheet:addHeader("Sources of uncertainties")
	sheet:addQuestion("How do your estimates of horizontal and vertical accelerations compare with your expected values? What are your expected values? If there is any difference, discuss the sources of uncertainties.")
	sheet:addCheckQuestion("Go to your demonstrator now and verify your results.")

    sheet:addHeader("Please export your data:")
    local exportButton = sheet:addExportButton()
end
