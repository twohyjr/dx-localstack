exports.handler = (event, context, callback) => {
    console.log('Hello, logs!');
    callback(null, 'Good Job On Executing This Lambda!');

    const response = {
        statusCode: 200,
        body: JSON.stringify('This lambda is working')
    }
    return response;
}