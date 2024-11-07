/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import * as functions from "firebase-functions/v2";
import * as admin from "firebase-admin";
import * as sharp from "sharp";
import { Storage } from "@google-cloud/storage";
import * as fs from "fs";
import * as path from "path";

admin.initializeApp();
const storage = new Storage();

export const generateThumbnail = functions.storage.onObjectFinalized({
    region: 'asia-southeast1',
    memory: '1GiB'
}, async (object) => {

    const bucket = storage.bucket(object.bucket);
    const filePath = object.data.name || "";
    const fileName = path.basename(filePath);
    const thumbnailFileName = `thumb_${fileName}`;
    const thumbnailFilePath = `thumbnails/${thumbnailFileName}`;
    console.log(`Thumbnail generation started ${thumbnailFilePath}`)


    if (fileName.startsWith("thumb_")) {
        console.log("Thumbnail already exists.");
        return;
    }

    const temp = path.join("/tmp", fileName);
    await bucket.file(filePath).download({ destination: temp });


    const thumbTempFilePath = path.join("/tmp", thumbnailFileName);
    await sharp(temp)
        .resize({ width: 400 })
        .toFile(thumbTempFilePath);


    await bucket.upload(thumbTempFilePath, {
        destination: thumbnailFilePath,
    });

    // Clean up temp files
    fs.unlinkSync(temp);
    fs.unlinkSync(thumbTempFilePath);

    console.log(`Thumbnail generation complete ${thumbnailFilePath}`)
});
