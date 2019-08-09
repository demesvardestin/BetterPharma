// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require chartkick
//= require Chart.bundle
//= require_tree .

// Begin the process of setting up the service worker.
// First check if the necessary APIs are supported, and if not,
// open a modal or user-friendly popup to alert the user.
// Then go on to register the service worker.

beginServiceWorkerProcess = () => {
    if (!('serviceWorker' in navigator)) {
        // Replace this with user friendlier alert (ie: modal popup)
        alert("Service worker isn't supported in this browser!");
        return;
    }
    
    if (!('PushManager' in window)) {
        // Replace this with user friendlier alert (ie: modal popup)
        alert("Push manager isn't supported in this browser!");
        return;
    }
    
    registerServiceWorker();
};

// Register service worker
registerServiceWorker = () => {
    return navigator.serviceWorker.register('/javascript/sw.js')
    .then( (registration) => {
        console.log('Service worker successfully registered.');
        return registration;
    })
    .catch( (err) => {
        console.error('Unable to register service worker.', err);
    });
};

// Ask user for notifications permission
askPermission = () => {
    return new Promise( (resolve, reject) => {
        const permissionResult = Notification.requestPermission(function(result) {
            resolve(result);
        });
    
        if (permissionResult) {
            permissionResult.then(resolve, reject);
            subscribeUserToPush()
        }
    })
    .then( (permissionResult) => {
        if (permissionResult !== 'granted') {
            throw new Error('We weren\'t granted permission.');
        }
    });
};

// Subscribe user to push notification
subscribeUserToPush = () => {
    return navigator.serviceWorker.register('/service-worker.js')
    .then(function(registration) {
        const subscribeOptions = {
            userVisibleOnly: true,
            applicationServerKey: urlBase64ToUint8Array(
                'BEl62iUYgUivxIkv69yViEuiBIa-Ib9-SkvMeAtA3LFgDzkrxZJjSgSnfckjBJuBkr3qBUYIHBQFLXYp5Nksh8U'
            )
        };
    
        return registration.pushManager.subscribe(subscribeOptions);
    })
    .then(function(pushSubscription) {
        console.log('Received PushSubscription: ', JSON.stringify(pushSubscription));
        saveSubscription(pushSubscription);
    });
};

saveSubscription = (subscription) => {
    let data = {
        clientType: "desktop",
        subscription: subscription,
        pharmacyID: currentPharmacyID
    };
    $.post('/api/save_subscription', data)
};

// Push notification trigger
triggerPushNotification = (data) => {
    $.get('/reload_requests'); // Reload/re-render requests to reflect new ones
    // Display push notification
};