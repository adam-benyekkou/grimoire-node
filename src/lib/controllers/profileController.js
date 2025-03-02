const profileController = {
    myProfile(req, res) {
        res.render('profile/myProfile');
    },

    singleProfile(req, res) {
        res.render('profile/profile');
    },

    profileSettings(req, res) {
    res.render('profile/profileSettings');}
}

export { profileController };