importScripts("https://www.gstatic.com/firebasejs/7.14.5/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.14.5/firebase-messaging.js");
firebase.initializeApp({
        apiKey: "AIzaSyBW2NTFhzbWBZ1rNNTk7bbEqabP_OzZfoI",
        authDomain: "gamingpanda-5d844.firebaseapp.com",
        databaseURL: "https://gamingpanda-5d844.firebaseio.com",
        projectId: "gamingpanda-5d844",
        storageBucket: "gamingpanda-5d844.appspot.com",
        messagingSenderId: "86142882871",
        appId: "1:86142882871:web:2e9febbe2cbea297055bb2",
        measurementId: "G-V9DWHYFTQJ"
});



const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});