function notFound(req, res, next) {
    const error = new Error('Resource Not Found');

    error.statusCode = 404;

    error.viewName = '404';

    next(error);
}

export { notFound }