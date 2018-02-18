'use strict';

var firebase = require('firebase');
require("firebase/firestore");
 var config = {
    apiKey: "AIzaSyBil8v41lqUNe42_dldtLXQHtoyct7-Cnk",
    authDomain: "projectnote-1156c.firebaseapp.com",
    databaseURL: "https://projectnote-1156c.firebaseio.com",
    projectId: "projectnote-1156c",
    storageBucket: "projectnote-1156c.appspot.com",
    messagingSenderId: "499892673872"
  };
  firebase.initializeApp(config);
  var db = firebase.firestore();

function buildSpeechletResponse(title, output, repromptText, shouldEndSession) {
    return {
        outputSpeech: {
            type: 'PlainText',
            text: output,
        },
        card: {
            type: 'Simple',
            title: `SessionSpeechlet - ${title}`,
            content: `SessionSpeechlet - ${output}`,
        },
        reprompt: {
            outputSpeech: {
                type: 'PlainText',
                text: repromptText,
            },
        },
        shouldEndSession,
    };
}

function buildResponse(sessionAttributes, speechletResponse) {
    return {
        version: '1.0',
        sessionAttributes,
        response: speechletResponse,
    };
}


// --------------- Functions that control the skill's behavior -----------------------

function getWelcomeResponse(callback) {
    // If we wanted to initialize the session to have some attributes we could add those here.
    const sessionAttributes = {};
    const cardTitle = 'Welcome';
    const speechOutput = 'Welcome to Project Note what would you like to listen to';
    // If the user either does not reply to the welcome message or says something that is not
    // understood, they will be prompted again with this text.
    const repromptText = 'Tell me a song to play, ' +
        'my favorite song is End game by Taylor Swift';
    const shouldEndSession = false;

    callback(sessionAttributes,
        buildSpeechletResponse(cardTitle, speechOutput, repromptText, shouldEndSession));
}

function handleSessionEndRequest(callback) {
    const cardTitle = 'Session Ended';
    const speechOutput = 'Thank you for using Project Note. Have a nice day!';
    // Setting this to true ends the session and exits the skill.
    const shouldEndSession = true;

    callback({}, buildSpeechletResponse(cardTitle, speechOutput, null, shouldEndSession));
}

function setSongTitle(intent, session, callback) {
    const cardTitle = '';
    const songTitle = intent.slots.song;
    let repromptText = '';
    let sessionAttributes = {};
    const shouldEndSession = true;
    let speechOutput = '';

    db.collection("broadcast").doc("testing").update({
    remote_action: "alexa|song|" + songTitle.value
})
.then(function() {
    console.log("Document successfully written!");

    speechOutput = "I added " + songTitle.value + " to the queue";

    callback(sessionAttributes,
         buildSpeechletResponse(cardTitle, speechOutput, repromptText, shouldEndSession));

})
.catch(function(error) {
    console.error("Error writing document: ", error);
});
  }


function setSongBack(intent, session, callback) {
    const cardTitle = '';
    //const songTitle = intent.slots.song;
    let repromptText = '';
    let sessionAttributes = {};
    const shouldEndSession = true;
    let speechOutput = '';

    db.collection("broadcast").doc("testing").update({
    remote_action: "alexa|previous"
})
.then(function() {
    console.log("Document successfully written!");
     speechOutput = "Returning to the previous song";

    callback(sessionAttributes,
         buildSpeechletResponse(cardTitle, speechOutput, repromptText, shouldEndSession));
})
.catch(function(error) {
    console.error("Error writing document: ", error);
});

}

function setSongAgain(intent, session, callback) {
    const cardTitle = '';
    //const songTitle = intent.slots.song;
    let repromptText = '';
    let sessionAttributes = {};
    const shouldEndSession = true;
    let speechOutput = '';

    db.collection("broadcast").doc("testing").update({
    remote_action: "alexa|restart"
})
.then(function() {
    console.log("Document successfully written!");
     
     speechOutput = "Restarting current song";
   
    callback(sessionAttributes,
         buildSpeechletResponse(cardTitle, speechOutput, repromptText, shouldEndSession));
})
.catch(function(error) {
    console.error("Error writing document: ", error);
});

}

function setSkipSong(intent, session, callback) {
    const cardTitle = '';
    //const songTitle = intent.slots.song;
    let repromptText = '';
    let sessionAttributes = {};
    const shouldEndSession = true;
    let speechOutput = '';

    db.collection("broadcast").doc("testing").update({
    remote_action: "alexa|skip"
})
.then(function() {
    console.log("Document successfully written!");
     speechOutput = "Skipping to the next song";

   
    callback(sessionAttributes,
         buildSpeechletResponse(cardTitle, speechOutput, repromptText, shouldEndSession));
})
.catch(function(error) {
    console.error("Error writing document: ", error);
});

}

function setNameSong(intent, session, callback) {
    const cardTitle = '';
    //const songTitle = intent.slots.song;
    let repromptText = '';
    let sessionAttributes = {};
    const shouldEndSession = true;
    let speechOutput = '';

    var testRef = db.collection('broadcast').doc('testing');
    var getDoc = testRef.get()
    .then(doc => {
        if (!doc.exists) {
            console.log('No such document!');
        } else {
            console.log('Document data:', doc.get('currentTrackDescription'));
        }

        speechOutput = "The current song is " + doc.get('currentTrackDescription');

         callback(sessionAttributes,
         buildSpeechletResponse(cardTitle, speechOutput, repromptText, shouldEndSession));
    })
    .catch(err => {
        console.log('Error getting document', err);
    });
    
}

function setResumeSong(intent, session, callback) {
    const cardTitle = '';
    let repromptText = '';
    let sessionAttributes = {};
    const shouldEndSession = true;
    let speechOutput = '';

    var testRef = db.collection('broadcast').doc('testing');
    var getDoc = testRef.get()
    .then(doc => {
        if (!doc.exists) {
            console.log('No such document!');
        } else {
            console.log('Document data:', doc.get('currentTrackDescription'));
        }

        db.collection("broadcast").doc("testing").update({
        remote_action: "alexa|play"
        })
        .then(function() {
            console.log("Document successfully written!");
                 speechOutput = "Playing " + doc.get('currentTrackDescription');

                callback(sessionAttributes,
                buildSpeechletResponse(cardTitle, speechOutput, repromptText, shouldEndSession));
            })
        .catch(function(error) {
            console.error("Error writing document: ", error);
        });

           
    })
    .catch(err => {
        console.log('Error getting document', err);
    });
    
}

function setPauseSong(intent, session, callback) {
    const cardTitle = '';
    //const songTitle = intent.slots.song;
    let repromptText = '';
    let sessionAttributes = {};
    const shouldEndSession = true;
    let speechOutput = '';

    db.collection("broadcast").doc("testing").update({
    remote_action: "alexa|pause"
})
.then(function() {
    console.log("Document successfully written!");
    speechOutput = "Song paused";

    callback(sessionAttributes,
         buildSpeechletResponse(cardTitle, speechOutput, repromptText, shouldEndSession));
})
.catch(function(error) {
    console.error("Error writing document: ", error);
});
     
}


/**
 * Called when the session starts.
 */
function onSessionStarted(sessionStartedRequest, session) {
    console.log(`onSessionStarted requestId=${sessionStartedRequest.requestId}, sessionId=${session.sessionId}`);
}

/**
 * Called when the user launches the skill without specifying what they want.
 */
function onLaunch(launchRequest, session, callback) {
    console.log(`onLaunch requestId=${launchRequest.requestId}, sessionId=${session.sessionId}`);

    // Dispatch to your skill's launch.
    getWelcomeResponse(callback);
}

/**
 * Called when the user specifies an intent for this skill.
 */
function onIntent(intentRequest, session, callback) {
    console.log(`onIntent requestId=${intentRequest.requestId}, sessionId=${session.sessionId}`);

    const intent = intentRequest.intent;
    const intentName = intentRequest.intent.name;

    // Dispatch to your skill's intent handlers
    if (intentName === 'PlaySong') {
        setSongTitle(intent, session, callback);
    } else if (intentName === 'SkipSong') {
        setSkipSong(intent, session, callback);
    } else if (intentName === 'PauseSong') {
        setPauseSong(intent, session, callback);
    } else if (intentName === 'ResumeSong') {
        setResumeSong(intent, session, callback);
    } else if (intentName === 'CurrentSong') {
        setNameSong(intent, session, callback);
    } else if (intentName === 'GoBackSong') {
        setSongBack(intent, session, callback);
    } else if (intentName === 'Repeat') {
        setSongAgain(intent, session, callback);
    } else if (intentName === 'AMAZON.HelpIntent') {
        getWelcomeResponse(callback);
    } else if (intentName === 'AMAZON.StopIntent' || intentName === 'AMAZON.CancelIntent') {
        handleSessionEndRequest(callback);
    } else {
        throw new Error('Invalid intent');
    }
}

function onSessionEnded(sessionEndedRequest, session) {
    console.log(`onSessionEnded requestId=${sessionEndedRequest.requestId}, sessionId=${session.sessionId}`);

}


// Route the incoming request based on type (LaunchRequest, IntentRequest,
// etc.) The JSON body of the request is provided in the event parameter.
exports.handler = (event, context, callback) => {
    try {
        context.callbackWaitsForEmptyEventLoop = false;
        console.log(`event.session.application.applicationId=${event.session.application.applicationId}`);

        /*
        if (event.session.application.applicationId !== 'amzn1.echo-sdk-ams.app.[unique-value-here]') {
             callback('Invalid Application ID');
        }*/
        

        if (event.session.new) {
            onSessionStarted({ requestId: event.request.requestId }, event.session);
        }

        if (event.request.type === 'LaunchRequest') {
            onLaunch(event.request,
                event.session,
                (sessionAttributes, speechletResponse) => {
                    callback(null, buildResponse(sessionAttributes, speechletResponse));
                });
        } else if (event.request.type === 'IntentRequest') {
            onIntent(event.request,
                event.session,
                (sessionAttributes, speechletResponse) => {
                    console.log("HI!");
                    callback(null, buildResponse(sessionAttributes, speechletResponse));
                });
        } else if (event.request.type === 'SessionEndedRequest') {
            onSessionEnded(event.request, event.session);
            callback();
        }
    } catch (err) {
        callback(err);
    }
};
