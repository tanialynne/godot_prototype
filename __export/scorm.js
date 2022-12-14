// call LMSInitialize()
var completionLMS = null
var successLMS = null
var scoreLMS = null
var mm_adl_API = null;
var bookVar = null;

var statusType = "passed/incomplete";

function mm_adlOnload(){
	console.log("called on load")
  mm_adl_API = pipwerks.SCORM.init();

	if(mm_adl_API){

    startTimer();
		var bookpage = getLessonLocation();
		console.log("bookpage: "+bookpage)
		if (bookpage.toString().length > 1 && bookpage.toString() != "null"){
			//a bookmark exists, so they've been here before
			isFirstVisit = false;
			var bookArr = bookpage.split("|");
			console.log(bookArr)
			if (bookArr[0] != 'null' && bookArr[1] != 'null'){
				circuitsVisited = bookArr[2].split(",");
				if ( confirmBookmark() ) {
					chosencircuit = parseFloat(bookArr[0]);
					currentScenario = parseFloat(bookArr[1]);
					resetCircuit(chosencircuit);
			  }else{
					showBookmarkCancelChecks()
				}
			}
		}
	}else{
		checkCookie();
	}
}

function showBookmarkCancelChecks(){
	var numCiruitsVisited = 0;
	for(i=0;i<numcircuits;i++){
		if (parseFloat(circuitsVisited[i]) == 1){
			$("#c"+i).addClass('visited');
			numCiruitsVisited++;
		}
	}
	if (numCiruitsVisited == circuitsVisited.length) finishCourse();
}

function getPlayerName(myvar){
	console.log(myvar)
	if(mm_adl_API){
		var fullname = pipwerks.SCORM.get( "cmi.learner_name");
		var nameArray = fullname.split(",")

		return nameArray[nameArray.length-1];
	}else{
		return "Jane";
	}
}

function finishCourse(){
	if(mm_adl_API){

    if (statusType.toLowerCase() == "passed/incomplete"){
      pipwerks.SCORM.set("cmi.success_status", "passed");
      pipwerks.SCORM.set("cmi.completion_status", "completed");
    }else if (statusType.toLowerCase() == "passed/failed"){
      pipwerks.SCORM.set("cmi.success_status", "passed");
      pipwerks.SCORM.set("cmi.completion_status", "completed");
  		//completionLMS = "completed";
    }else if (statusType.toLowerCase() == "complete/incomplete"){
      pipwerks.SCORM.set("cmi.completion_status", "completed");
  		//completionLMS = "completed";
    }else if (statusType.toLowerCase() == "complete/failed"){
      pipwerks.SCORM.set("cmi.completion_status", "completed");
  		//completionLMS = "completed";
    }
	}else{
		console.log("finishCourse")
	}
}

// call LMSFinish()
function mm_adlOnunload()
{
  if(mm_adl_API){ niExit() }
}

function getLessonLocation() {
	//console.log("location: "+pipwerks.SCORM.get( "cmi.location"))
	return pipwerks.SCORM.get( "cmi.location");
}

function setBookmark( this_location ) {
	bookpage = getLessonLocation();
	computeTime();
	pipwerks.SCORM.set("cmi.location", this_location );
	pipwerks.SCORM.save();
//pipwerks.SCORM.set("cmi.exit", "cmi.suspend_data" );
	console.log("set bookmark: "+pipwerks.SCORM.get( "cmi.location"))
}

function confirmBookmark() {
	//console.log("confirmBookmark: " + title)
	result = confirm('Do you wish to return to your last location?');
	if ( result ) {
		return true;
	} else {
		return false;
	}
}

function getScoringCurrentTime(){
	return new Date().getTime();
}
function getScoringTimestamp(){
	//if(mm_adl_API){
		var t = new Date().toLocaleString();
		var tempArr = t.split(', ');
		var dateArr = tempArr[0].split('/');
		var tempTimeArr = tempArr[1].split(' ');
		var timeArr = tempTimeArr[0].split(':');

		var month = dateArr[0];
		var day = dateArr[1];
		var year = dateArr[2];

		var hour = timeArr[0];
		var minute = timeArr[1];
		var second = timeArr[2];

		if (month.toString().length < 2){
			month = "0"+month;
		}
		if (day.toString().length < 2){
			day = "0"+day;
		}
		if (hour.toString().length < 2){
			hour = "0"+hour;
		}

		//timestamp should be in the format 2009-07-25T03:00:00.0Z
		var timestamp = year+"-"+month+"-"+day+"T"+hour+":"+minute+":"+second+".0Z";

		return timestamp;
	//}
}

var interactionNum = 0;
var lastInteractionNum = 0;
//GetValue(‘cmi.interactions._count’)

function setSCORMInteraction(id, type, time, correctResponses, learnerResponse, result, latency, description){
	interactionNum = pipwerks.SCORM.get("cmi.interactions._count");
	if (interactionNum == null || interactionNum == 'null' || interactionNum == 'undefined') {
    interactionNum = parseFloat(lastInteractionNum)+1;
  }
	console.log(interactionNum+" : "+id+" : "+type+" : "+time+" : "+correctResponses+" : "+learnerResponse+" : "+result+" : "+latency+" : "+description)
	pipwerks.SCORM.set("cmi.interactions."+interactionNum+".id",id);
	pipwerks.SCORM.set("cmi.interactions."+interactionNum+".type",type);
	pipwerks.SCORM.set("cmi.interactions."+interactionNum+".timestamp",time);
	pipwerks.SCORM.set("cmi.interactions."+interactionNum+".correct_responses.0.pattern",correctResponses);
	pipwerks.SCORM.set("cmi.interactions."+interactionNum+".weighting","1");
	pipwerks.SCORM.set("cmi.interactions."+interactionNum+".learner_response",learnerResponse);
	pipwerks.SCORM.set("cmi.interactions."+interactionNum+".result",result);
	pipwerks.SCORM.set("cmi.interactions."+interactionNum+".latency",latency);
	pipwerks.SCORM.set("cmi.interactions."+interactionNum+".description",description);
	lastInteractionNum = interactionNum;
	interactionNum++;

	getSCORMInteractions()
}


var startSession;
function startTimer(){
   startSession = new Date().getTime();
	startDate = pipwerks.SCORM.get( "cmi.total_time");
}

function computeTime(){
   if ( startDate != 0 )
   {
      var currentDate = new Date().getTime();
      var elapsedSeconds = ( (currentDate - startDate) / 1000 );
      var formattedTime = convertTotalSeconds( elapsedSeconds );
   }
   else
   {
      var formattedTime = "00:00:00.0";
   }
  pipwerks.SCORM.set( "cmi.session_time", "00:00:00.0" );
  pipwerks.SCORM.set( "cmi.total_time", formattedTime );
  pipwerks.SCORM.save();
}

function convertTotalSeconds(ts){
   var sec = (ts % 60);

   ts -= sec;
   var tmp = (ts % 3600);
   ts -= tmp;

   sec = Math.round(sec*100)/100;

   var strSec = new String(sec);
   var strWholeSec = strSec;
   var strFractionSec = "";

   if (strSec.indexOf(".") != -1) {
      strWholeSec =  strSec.substring(0, strSec.indexOf("."));
      strFractionSec = strSec.substring(strSec.indexOf(".")+1, strSec.length);
   }

   strSec = strWholeSec;

   if (strFractionSec.length) {
      strSec = strSec+ "." + strFractionSec;
   }

   if ((ts % 3600) != 0 )
      var hour = 0;
   else var hour = (ts / 3600);
   if ( (tmp % 60) != 0 )
      var min = 0;
   else var min = (tmp / 60);

   var rtnVal = "PT"+hour+"H"+min+"M"+strSec+"S";
   return rtnVal;
}
/*
function submitScore(thisScore, minScore, maxScore, passScore){
	if (mm_adl_API) {

		console.log("connected to api - submitted score");
		scoreLMS = thisScore/100;
		pipwerks.SCORM.set("cmi.score.scaled",scoreLMS);
		pipwerks.SCORM.save();
		pipwerks.SCORM.set("cmi.score.min",0);
		pipwerks.SCORM.save();
		 pipwerks.SCORM.set("cmi.score.max",100);
		 pipwerks.SCORM.save();
		if (thisScore >= passScore) {
			didPass = true;
			pipwerks.SCORM.set("cmi.success_status", "passed");
			successLMS = "passed";
			pipwerks.SCORM.save();
		}else{
			didPass = false;
			pipwerks.SCORM.set("cmi.success_status", "failed");
			successLMS = "failed";
			pipwerks.SCORM.save();
		}
		pipwerks.SCORM.set("cmi.completion_status", "completed");
		completionLMS = "completed";
		pipwerks.SCORM.save();
	} else {
		console.log("API not Connected");
	}
	console.log(pipwerks.SCORM.get("cmi.score.scaled")+" : "+pipwerks.SCORM.get("cmi.completion_status")+" : "+pipwerks.SCORM.get("cmi.success_status"));
}
*/

function niExit(){
	pipwerks.SCORM.save();
	pipwerks.SCORM.quit();
	// if in new window use this function
	window.top.close();
	// if frametset use this function
	playerWindow.Control.TriggerReturnToLMS();
}

var interactionStartTime = getScoringCurrentTime();
var interactionTimeStamp = getScoringTimestamp();
var interactionAnswerTime;
var interactionElapsedSeconds;
var interactionFormattedTime;

var interactionID = 'exam';
var interactionType = 'choice'
var interactionCorrectResponse = 'expected_answer';
var interactionGotCorrect = 'neutral';
var interactionDescription = 'Exam question one';
var interactionLearnerResponse = '';
var newinteractionID = '';

function doSetInteraction(newinteractionID){
	interactionAnswerTime = getScoringCurrentTime();
	interactionElapsedSeconds = ( (interactionAnswerTime - interactionStartTime) / 1000 );
	interactionFormattedTime = convertTotalSeconds( interactionElapsedSeconds );
	console.log("formattedTime: "+interactionFormattedTime);

	setSCORMInteraction(newinteractionID, interactionType, interactionTimeStamp, interactionCorrectResponse,
							interactionLearnerResponse, interactionGotCorrect, interactionFormattedTime, interactionDescription);

	console.log(newinteractionID+" : "+interactionType+" : "+interactionTimeStamp+" : "+interactionCorrectResponse
				+" : "+interactionLearnerResponse+" : "+interactionGotCorrect+" : "+interactionFormattedTime+" : "+interactionDescription);
}


var questionAnsweredArr = [];
questionAnsweredArr[0] = [];
questionAnsweredArr[0][0] = [0,0,0,0,0,0,0]; //simple series normal
questionAnsweredArr[0][1] = [0,0,0,0,0,0,0]; //simple series scenario 1
questionAnsweredArr[0][2] = [0,0,0,0,0,0,0]; //simple series scenario 2
questionAnsweredArr[1] = [];
questionAnsweredArr[1][0] = [0,0,0,0,0,0,0]; //simple parallel normal
questionAnsweredArr[1][1] = [0,0,0,0,0,0,0,0]; //simple parallel scenario 1
questionAnsweredArr[2] = [];
questionAnsweredArr[2][0] = [0,0,0,0,0,0,0,0,0]; //simple series-parallel normal
questionAnsweredArr[2][1] = [0,0,0,0,0,0,0,0,0]; //simple series-parallel scenario 1
questionAnsweredArr[2][2] = [0,0,0,0,0,0,0,0,0,0]; //simple series-parallel scenario 2
questionAnsweredArr[3] = [];
questionAnsweredArr[3][0] = [0,0,0,0,0,0,0,0,0]; //simple relay normal
questionAnsweredArr[4] = [];
questionAnsweredArr[4][0] = [0,0,0,0,0,0,0,0,0]; //3 bulb parallel normal
questionAnsweredArr[4][1] = [0,0,0,0,0,0,0,0,0,0]; //3 bulb parallel scenario 1
questionAnsweredArr[5] = [];
questionAnsweredArr[5][0] = [0,0,0,0]; //single bulb series normal
questionAnsweredArr[6] = [];
questionAnsweredArr[6][0] = [0,0,0,0]; //single bulb pushbutton series normal



function getSCORMInteractions(){
	var totalNumQuestions = 0;
	var totalQuestionsAnswered = 0;
	var totalQuestionsCorrect = 0;
	var num = parseFloat(pipwerks.SCORM.get("cmi.interactions._count"));

	for (i=0;i<num;i++){
		var id = pipwerks.SCORM.get("cmi.interactions."+i+".id");
		var result = pipwerks.SCORM.get("cmi.interactions."+i+".result");
		var idarr = id.split("-");
		var circuit = parseFloat(idarr[0]);
		var scenario = parseFloat(idarr[1]);
		var qnum = parseFloat(idarr[2]);
		questionAnsweredArr[circuit][scenario][qnum] = result;
	}

	for (n=0;n<questionAnsweredArr.length;n++){
		for (p=0;p<questionAnsweredArr[n].length;p++){
			for (q=0;q<questionAnsweredArr[n][p].length;q++){
				totalNumQuestions++;
					if(questionAnsweredArr[n][p][q] != 0){
					totalQuestionsAnswered++;
					if ( questionAnsweredArr[n][p][q] == 'correct') totalQuestionsCorrect++;
				}
			}
		}
	}
	//console.log(questionAnsweredArr)
	/*if (totalNumQuestions == totalQuestionsAnswered){
		console.log(totalQuestionsCorrect+" : "+totalNumQuestions)
		examScore = Math.round((totalQuestionsCorrect/totalNumQuestions) * 100);
		submitScore(examScore,0,100,80);
	}*/
}

var cookieName ="ImmersedBreadboardStreamlined";

function getCookie(c_name){
	var c_value = document.cookie;
	var c_start = c_value.indexOf(" " + c_name + "=");
	if (c_start == -1){
		c_start = c_value.indexOf(c_name + "=");
	}
	if (c_start == -1){
		c_value = null;
	}else{
		c_start = c_value.indexOf("=", c_start) + 1;
	var c_end = c_value.indexOf(";", c_start);
	if (c_end == -1){
		c_end = c_value.length;
	}
		c_value = unescape(c_value.substring(c_start,c_end));
	}
	return c_value;
}

function setCookie(c_name,value,exdays){
	var exdate=new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
	document.cookie=c_name + "=" + c_value;
}

function clearCookie(c_name){
	var mydate = new Date();
	mydate.setTime(mydate.getTime() - 1);
	var c_value="; expires="+mydate.toGMTString();
	document.cookie=c_name + "=" + c_value;
}


function checkCookie(){
	var myBookVar=getCookie(cookieName);
	if (myBookVar != null){
			//a bookmark exists, so they've been here before
			isFirstVisit = false;
		  var bookArr = myBookVar.split("|");
			if (bookArr[0] != 'null' && bookArr[1] != 'null'){
				circuitsVisited = bookArr[2].split(",");
				if ( confirmBookmark() ) {
					chosencircuit = parseFloat(bookArr[0]);
					currentScenario = parseFloat(bookArr[1]);
					resetCircuit(chosencircuit);
			  }else{
					showBookmarkCancelChecks()
				}
			}
	}
}
