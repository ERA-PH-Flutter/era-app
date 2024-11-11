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
import { onCall } from "firebase-functions/https";
import { tmpdir } from 'os';

admin.initializeApp();
const storage = new Storage();

export const generateThumbnail = functions.storage.onObjectFinalized({
    region: 'asia-southeast1',
    memory: '1GiB'
}, async (object) => {

    const bucket = storage.bucket(object.bucket);
    const filePath = object.data.name || "";

    const allowedDirectories = ['projects', 'news', 'banners', 'listings']

    const filePathSplit = filePath.split('/')


    // only allow 
    if (!allowedDirectories.includes(filePathSplit[0]) || filePathSplit.includes('thumbnails')) return

    const fileName = path.basename(filePath);
    const fileDir = path.dirname(filePath);

    const thumbnailFileName = `thumb_${fileName}`;
    const thumbnailFilePath = `${fileDir}/thumbnails/thumb_${fileName}`;

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


export const migrateGenerateThumbnail = onCall({
    region: 'asia-southeast1',
    memory: '1GiB'
}, async (e) => {
    const storage = admin.storage().bucket();

    // const directories = ['projects','news','banners','listings']
    const directories = ['projects']
    let count: number = 0;
    for (const directory of directories) {

        if (count > 20) break;
        count++;
        const [files] = await storage.getFiles({ prefix: directory });
        const projectImages = files.map(async (file) => {
            const fileName = file.name;
            const filePathSplit = fileName.split('/')

            if (fileName.startsWith("thumb_") || filePathSplit.includes('thumbnails')) {
                console.log("Thumbnail already exists.");
                return;
            }
            const fileDir = path.dirname(fileName);
            const tempFilePath = path.join(tmpdir(), fileName);

            await file.download({ destination: tempFilePath });


            const thumbFileName = `${fileDir}/thumbnails/thumb_${fileName}`;
            const thumbTempFilePath = path.join(tmpdir(), thumbFileName);


            await sharp(tempFilePath)
                .resize({ width: 400 })
                .toFile(thumbTempFilePath);

            // Upload the thumbnail to Firebase Storage
            await storage.upload(thumbTempFilePath, {
                destination: path.join(fileDir, thumbFileName),
                metadata: {
                    contentType: 'image/jpeg',
                },
            });
            fs.unlinkSync(tempFilePath);
            fs.unlinkSync(thumbTempFilePath);
        });
        await Promise.all(projectImages);
    }
    console.log(`Thumbnail generation migration complete`);
});




export const deleteUser = onCall({ region: 'asia-southeast1', }, async (req) => {
    const uid = req.auth?.uid// Assuming the UID is passed in the request body
    try {
        if (uid != null) {
            const documentRef = admin.firestore().collection('users').doc(uid);
            await documentRef.delete();
            await admin.auth().deleteUser(uid);
        }
        else {
            console.error('Cannot delete user')
        }
    } catch (error) {
        console.error(`Error deleting user: ${uid}`, error);
    }
});


export const projectQuery = onCall({ region: 'asia-southeast1', enforceAppCheck: false, }, async (req) => {
    const uid = req.auth?.uid
    try {
        const searchQuery: string = (req.data['searchQuery'] ?? '').trim()
        let projectsDocs = (await admin.firestore().collection('projects').get()).docs;
        const rankedDocuments = [];
        for (const doc of projectsDocs) {
            const documentId = doc.id;
            const documentData = doc.data();
            const jsonString = JSON.stringify(documentData);

            // Tokenize the search query and the document
            const queryTokens = searchQuery.split(',').map((e) => e.toLocaleLowerCase());
            const documentTokens = jsonString.toLocaleLowerCase();

            // Calculate a simple score based on token overlapF
            let score = calculateScore(queryTokens, documentTokens);

            if (score < 1) continue
            rankedDocuments.push({
                documentId: documentId,
                documentData: jsonString,
                score: score
            });

        }

        // Sort the documents by score in descending order
        rankedDocuments.sort((a, b) => b.score - a.score);

        return rankedDocuments.map((e) => e.documentId)
    } catch (error) {
        console.error(`Error ${uid}`, error);
        return []
    }
});
export const listingQuery = onCall({ region: 'asia-southeast1', enforceAppCheck: false, }, async (req) => {
    const uid = req.auth?.uid
    try {
        const searchQuery: string = (req.data['searchQuery'] ?? '').trim()
        let projectsDocs = (await admin.firestore().collection('listings').get()).docs;
        const rankedDocuments = [];
        for (const doc of projectsDocs) {
            const documentId = doc.id;
            const documentData = doc.data();
            const jsonString = JSON.stringify(documentData);

            // Tokenize the search query and the document
            const queryTokens = searchQuery.split(',').map((e) => e.toLocaleLowerCase());
            const documentTokens = jsonString.toLocaleLowerCase();

            // Calculate a simple score based on token overlapF
            let score = calculateScore(queryTokens, documentTokens);

            if (score < 1) continue
            rankedDocuments.push({
                documentId: documentId,
                documentData: jsonString,
                score: score
            });

        }

        // Sort the documents by score in descending order
        rankedDocuments.sort((a, b) => b.score - a.score);

        return rankedDocuments.map((e) => e.documentId)
    } catch (error) {
        console.error(`Error ${uid}`, error);
        return []
    }
});
function calculateScore(queryTokens: string[], documentTokens: string) {
    let score = 0;
    for (const queryToken of queryTokens) {
        if (documentTokens.includes(queryToken)) {
            score++;
        }
        const splitQuery = queryToken.split(' ').map((e) => e.toLocaleLowerCase());
        for (const val of splitQuery) {
            if (documentTokens.includes(val)) {
                score = score + .3;
            }
        }
    }
    return score;
}
