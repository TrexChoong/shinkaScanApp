// web/web_camera_capture.js

// Ensure these are immediately defined globally on the window object
window.currentStream = null; // Global variable to hold the media stream
window.videoElement = null; // Reference to the dynamically created video element

/**
 * Starts the webcam, captures a single frame, and returns it as a Base64 string.
 * This function handles creating a temporary video element, playing the stream,
 * drawing to a canvas, and stopping the stream.
 * @returns {Promise<string|null>} A Promise that resolves with the Base64 image string,
 * or rejects with an error if permission is denied or capture fails.
 */
window.startWebCameraAndCapture = function() {
    return new Promise(async (resolve, reject) => { // Added reject parameter
        try {
            // Request camera access
            const stream = await navigator.mediaDevices.getUserMedia({ video: true });
            window.currentStream = stream; // Store stream for later stopping

            // Create a temporary video element if it doesn't exist
            if (!window.videoElement) {
                window.videoElement = document.createElement('video');
                window.videoElement.style.display = 'none'; // Keep it hidden
                window.videoElement.autoplay = true;
                window.videoElement.playsInline = true; // Important for iOS for autoplay
                window.videoElement.muted = true; // Mute to prevent audio feedback
                document.body.appendChild(window.videoElement); // Append to body
            }

            window.videoElement.srcObject = stream;

            // Use a promise to wait for video to load metadata and be ready to play
            await new Promise(resolveVideo => {
                window.videoElement.onloadedmetadata = () => {
                    window.videoElement.play();
                    resolveVideo();
                };
                // Handle cases where metadata might already be loaded (e.g., if re-using video element)
                if (window.videoElement.readyState >= 2) { // HTMLMediaElement.HAVE_CURRENT_DATA or more
                    resolveVideo();
                }
            });

            // Give a small delay for the stream to stabilize before capturing
            setTimeout(() => {
                const canvas = document.createElement('canvas');
                canvas.width = window.videoElement.videoWidth;
                canvas.height = window.videoElement.videoHeight;
                const context = canvas.getContext('2d');

                if (context) {
                    context.drawImage(window.videoElement, 0, 0, canvas.width, canvas.height);
                    const imageData = canvas.toDataURL('image/jpeg', 0.9); // Get Base64 JPEG data, 0.9 quality
                    resolve(imageData); // Resolve the promise with the image data
                } else {
                    console.error("Could not get 2D context for canvas.");
                    resolve(null); // Resolve with null on canvas context error
                }

                // Stop the camera tracks after capturing
                window.stopWebCamera();
            }, 500); // 500ms delay to allow camera to stabilize

        } catch (err) {
            console.error("Error accessing camera:", err);
            // Reject the promise with the error for Dart to catch
            reject(err);
            window.stopWebCamera(); // Ensure tracks are stopped even on error
        }
    });
};

/**
 * Stops the active webcam stream and cleans up the video element.
 */
window.stopWebCamera = function() {
    if (window.currentStream) {
        window.currentStream.getTracks().forEach(track => track.stop());
        window.currentStream = null;
    }
    // Optionally remove the video element from the DOM if it was dynamically created
    // and is no longer needed. For this specific use case (capture and dispose),
    // removing it is good practice to clean up the DOM.
    if (window.videoElement && window.videoElement.parentNode) {
        window.videoElement.parentNode.removeChild(window.videoElement);
        window.videoElement = null;
    }
};
