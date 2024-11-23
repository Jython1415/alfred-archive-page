#!/usr/bin/osascript

function run(argv) {
  const query = argv[0];

  const responseCodeMatch = query.match(/^HTTP\/\d+ (\d+)/m);
  const responseCode = responseCodeMatch ? responseCodeMatch[1] : "error";

  const locationMatch = query.match(/^location:\s*(.+)$/m);
  const location = locationMatch ? locationMatch[1].trim() : "error";

  // Combine response code and location value with delimiter
  return `${responseCode} | ${location}`;
}
