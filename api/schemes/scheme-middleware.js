const Scheme = require('./scheme-model')
/*
  If `scheme_id` does not exist in the database:

  status 404
  {
    "message": "scheme with scheme_id <actual id> not found"
  }
*/
async function checkSchemeId(req, res, next) {
  const { scheme_id } = req.params;
  const scheme = await Scheme.findById(scheme_id);
  if (scheme) {
    req.scheme = scheme;
    next();
  } else {
    res.status(404).json({
      message: `scheme with scheme_id ${scheme_id} not found`
    });
  }
}

/*
  If `scheme_name` is missing, empty string or not a string:

  status 400
  {
    "message": "invalid scheme_name"
  }
*/
function validateScheme(req, res, next) {
  const { scheme_name } = req.body;
  if (!scheme_name || typeof scheme_name !== 'string') {
    res.status(400).json({
      message: 'invalid scheme_name'
    })
  } else {
    next();
  }
}

/*
  If `instructions` is missing, empty string or not a string, or
  if `step_number` is not a number or is smaller than one:

  status 400
  {
    "message": "invalid step"
  }
*/
function validateStep(req, res, next) {
  const { step_number, instructions } = req.body;
  if (
    step_number == null ||
    typeof step_number !== 'number' ||
    step_number < 1 ||
    !instructions ||
    typeof instructions !== 'string') {
    res.status(400).json({
      message: 'invalid step'
    });
  } else {
    next();
  }
}

module.exports = {
  checkSchemeId,
  validateScheme,
  validateStep,
}
