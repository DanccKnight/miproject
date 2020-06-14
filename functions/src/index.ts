import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();
const db = admin.firestore();
const fcm = admin.messaging();

    export const sendNotificationToCaretakers = functions.firestore
    .document('Notifications/{notificationId}')
    .onCreate(async snapshot => {
        const patient = snapshot.data();
        var tokens = [];

        await db.collection('Admins').get()
            .then((snapshot) => {

                if(snapshot.empty)
                    console.log('No devices');
                else {

                    for(var doc of snapshot.docs){
                        tokens.push(doc.data().token)
                    }
                }
            })

        const payload = {
            notification: {
                title: `${patient.name} is calling for help`,
                body: `Rush to Room No. ${patient.room_no} now!`,
                clickAction: 'FLUTTER_NOTIFICATION_CLICK',
            },
        };

        return fcm.sendToDevice(tokens, payload);
    });

