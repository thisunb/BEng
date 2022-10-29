var currentQuestion = 0;
var score = 0;
var totQuestions = questions.length;

var grid = document.getElementById('grid');
var questionEl = document.getElementById('question');
var choice1 =document.getElementById('choice1');
var choice2 =document.getElementById('choice2');
var choice3 =document.getElementById('choice3');
var choice4 =document.getElementById('choice4');
var resultCont =document.getElementById('result');


var total_seconds=60*10;
var minutes =parseInt(total_seconds/60);
var seconds = parseInt(total_seconds%60);


function loadQuestion(questionIndex) {
	var q = questions[questionIndex];
	questionEl.textContent = (questionIndex + 1) + '.' + q.question;
	choice1.textContent=q.option1;
	choice2.textContent=q.option2;
	choice3.textContent=q.option3;
	choice4.textContent=q.option4;
};


function loadNextQuestion () {
	var selectedOption = document.querySelector('input[type=radio]:checked');
		
	
	var answer = selectedOption.value;
	if(questions[currentQuestion].answer == answer){
		score = score + 2;
		
	}

	else{
		score = score - 1;
	}

	selectedOption = false;
	currentQuestion++;
	

	if(currentQuestion == totQuestions){
	 	grid.style.display = 'none';
		resultCont.style.display = '';
		
		if (score<=0) {
			score=0;
			resultCont.style.backgroundColor="red";
		}
		if (score<5) {
			resultCont.style.backgroundColor = "red";
		}
		else if(score<12){
			resultCont.style.backgroundColor = "orange";
		}

		else{
			resultCont.style.backgroundColor = "green";
		}
		
		resultCont.textContent ="Your Score :" + score;
	


		return;
	}

	loadQuestion(currentQuestion);
};


var h3 = document.getElementsByTagName("h3");
h3[0].innerHTML = "Time Remaining";

var sec         = 600,
    countDiv    = document.getElementById("timer"),
    secpass,
    countDown   = setInterval(function () {
       

    var min     = Math.floor(sec / 60),
    remSec  = sec % 60;
    
    if (remSec < 10) {
        remSec = '0' + remSec;
       
    
    }
    if (min < 10) {
        min = '0' + min;
        
    
    }
    
    countDiv.innerHTML = min + ":" + remSec; 
   
    if (sec > 0) {
        sec = sec - 1;
        
    } else {
    
		
       	clearInterval(countDown);
        countDiv.innerHTML = "Time's up";
        grid.style.display = 'none';
		resultCont.style.display = '';
		resultCont.textContent ="Your Score:" + score;
        
    }
        
    }, 1000);

loadQuestion(currentQuestion);



