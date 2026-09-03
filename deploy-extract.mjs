import AdmZip from "adm-zip";
import { execSync } from "node:child_process";
import { existsSync } from "node:fs";

const zip = new AdmZip("fable-relationship-v0.2.zip");
zip.extractAllTo(".", true);

if (!existsSync("package.json")) {
  throw new Error("Fable package.json was not extracted");
}

execSync("npm install", { stdio: "inherit" });
