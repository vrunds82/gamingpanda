

  // Your web app's Firebase configuration
  var firebaseConfig = {
    apiKey: "AIzaSyBW2NTFhzbWBZ1rNNTk7bbEqabP_OzZfoI",
    authDomain: "gamingpanda-5d844.firebaseapp.com",
    databaseURL: "https://gamingpanda-5d844.firebaseio.com",
    projectId: "gamingpanda-5d844",
    storageBucket: "gamingpanda-5d844.appspot.com",
    messagingSenderId: "86142882871",
    appId: "1:86142882871:web:2e9febbe2cbea297055bb2",
    measurementId: "G-V9DWHYFTQJ"
  };
  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
  firebase.analytics();



firebase.initializeApp(firebaseConfig);
firebase.analytics();



var messaging = firebase.messaging()

messaging.usePublicVapidKey('BLDg8iHly38kfcLUfYHiv34g9IG5dOciirI66IPHP3bO2E6wsk84DWZRY2mEEhGb7pqwzMYQ8usOv61JnLsRABU');

messaging.getToken().then((currentToken) => {
    console.log(currentToken)
})