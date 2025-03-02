function errorHandler(err, req, res, next) {

    const statusCode = err.statusCode || 500;

    const viewName = err.viewName || 'error';


    // ? Il faudrait vérifier sur notre environnement si on est en production ou en développement : selon le cas, on n'affiche pas le même message

    res.status(statusCode).render(viewName, { message: err.message, stack: err.stack });
}

export { errorHandler };