using BookAPI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BookAPI.Services
{
    public class ReviewerRepository : IReviewerRepository
    {
        private readonly BookDbContext _reviwerContext;

        public ReviewerRepository(BookDbContext reviewrContext)
        {
            _reviwerContext = reviewrContext;
        }

        public bool CreateReviewer(Reviewer reviewer)
        {
            _reviwerContext.Add(reviewer);
            return Save();
        }

        public bool DeleteReviewer(Reviewer reviewer)
        {
            _reviwerContext.Remove(reviewer);
            return Save();
        }

        public Reviewer GetReviewer(int reviewerId)
        {
            return _reviwerContext.Reviewers.Where(r => r.Id == reviewerId).FirstOrDefault();
        }

        public Reviewer GetReviewerOfReview(int reviewId)
        {
            var reviewerId = _reviwerContext.Reviews.Where(r => r.Id == reviewId).Select(rr=>rr.Reviewer.Id).FirstOrDefault();
            return _reviwerContext.Reviewers.Where(r => r.Id == reviewerId).FirstOrDefault();

        }

        public ICollection<Reviewer> GetReviewers()
        {
            return _reviwerContext.Reviewers.OrderBy(r => r.LastName).ToList();
        }

        public ICollection<Review> GetReviewsByReviewer(int reviewerId)
        {
            return _reviwerContext.Reviews.Where(r => r.Reviewer.Id == reviewerId).ToList();
        }

        public bool ReviewerExists(int reviewerId)
        {
            return _reviwerContext.Reviewers.Any(r => r.Id == reviewerId);
        }

        public bool Save()
        {
            var saved = _reviwerContext.SaveChanges();
            return saved >= 0 ? true : false;
        }

        public bool UpdateReviewer(Reviewer reviewer)
        {
            _reviwerContext.Update(reviewer);
            return Save();
        }
    }
}
