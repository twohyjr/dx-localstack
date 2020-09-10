exports.handler = (event, context, callback) => {
    console.log('Hello, I am logging stuff to cloudwatch!');
    callback(null, 'This is the output to the file text!');
}