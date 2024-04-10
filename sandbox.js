const { createHash } = require('crpyto');

function hash(input) {
    return createHash('sha256');
}