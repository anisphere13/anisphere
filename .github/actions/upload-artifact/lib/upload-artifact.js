"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const core = __importStar(require("@actions/core"));
const artifact_1 = require("@actions/artifact");
const search_1 = require("./search");
const input_helper_1 = require("./input-helper");
const constants_1 = require("./constants");
function run() {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const inputs = (0, input_helper_1.getInputs)();
            const searchResult = yield (0, search_1.findFilesToUpload)(inputs.searchPath);
            if (searchResult.filesToUpload.length === 0) {
                // No files were found, different use cases warrant different types of behavior if nothing is found
                switch (inputs.ifNoFilesFound) {
                    case constants_1.NoFileOptions.warn: {
                        core.warning(`No files were found with the provided path: ${inputs.searchPath}. No artifacts will be uploaded.`);
                        break;
                    }
                    case constants_1.NoFileOptions.error: {
                        core.setFailed(`No files were found with the provided path: ${inputs.searchPath}. No artifacts will be uploaded.`);
                        break;
                    }
                    case constants_1.NoFileOptions.ignore: {
                        core.info(`No files were found with the provided path: ${inputs.searchPath}. No artifacts will be uploaded.`);
                        break;
                    }
                }
            }
            else {
                const s = searchResult.filesToUpload.length === 1 ? '' : 's';
                core.info(`With the provided path, there will be ${searchResult.filesToUpload.length} file${s} uploaded`);
                core.debug(`Root artifact directory is ${searchResult.rootDirectory}`);
                if (searchResult.filesToUpload.length > 10000) {
                    core.warning(`There are over 10,000 files in this artifact, consider creating an archive before upload to improve the upload performance.`);
                }
                const artifactClient = (0, artifact_1.create)();
                const options = {
                    continueOnError: false
                };
                if (inputs.retentionDays) {
                    options.retentionDays = inputs.retentionDays;
                }
                const uploadResponse = yield artifactClient.uploadArtifact(inputs.artifactName, searchResult.filesToUpload, searchResult.rootDirectory, options);
                if (uploadResponse.failedItems.length > 0) {
                    core.setFailed(`An error was encountered when uploading ${uploadResponse.artifactName}. There were ${uploadResponse.failedItems.length} items that failed to upload.`);
                }
                else {
                    core.info(`Artifact ${uploadResponse.artifactName} has been successfully uploaded!`);
                }
            }
        }
        catch (error) {
            core.setFailed(error.message);
        }
    });
}
run();
//# sourceMappingURL=upload-artifact.js.map